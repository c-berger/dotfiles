"""StarDict reader and search. No Keypirinha dependency, so it can be tested alone."""

import bisect
import gzip
import os
import pickle
import struct
import unicodedata
import zlib
from html.parser import HTMLParser

CACHE_VERSION = 1


def normalize(text):
    # casefold turns "ß" into "ss". NFKD + dropping marks lets "gebaude" match "Gebäude".
    text = unicodedata.normalize("NFKD", text.casefold())
    return "".join(c for c in text if not unicodedata.combining(c))


def read_ifo(path):
    info = {}
    with open(path, encoding="utf-8") as f:
        for line in f.read().splitlines()[1:]:
            key, _, value = line.partition("=")
            info[key.strip()] = value.strip()
    return info


class DictZip:
    """Random access to a dictzip file. Each chunk is an independent deflate block."""

    def __init__(self, path):
        self._path = path
        self._chunk_cache = {}
        with open(path, "rb") as f:
            head = f.read(10)
            if head[:2] != b"\x1f\x8b" or not head[3] & 4:
                raise ValueError("not a dictzip file: " + path)
            xlen = struct.unpack("<H", f.read(2))[0]
            extra = f.read(xlen)
            pos = 0
            while pos < xlen:
                sub_id = extra[pos:pos + 2]
                sub_len = struct.unpack("<H", extra[pos + 2:pos + 4])[0]
                if sub_id == b"RA":
                    _, self._chunk_len, count = struct.unpack("<HHH", extra[pos + 4:pos + 10])
                    sizes = struct.unpack("<%dH" % count, extra[pos + 10:pos + 10 + 2 * count])
                    break
                pos += 4 + sub_len
            else:
                raise ValueError("no dictzip chunk table: " + path)
            if head[3] & 8:  # original file name
                while f.read(1) != b"\0":
                    pass
            if head[3] & 16:  # comment
                while f.read(1) != b"\0":
                    pass
            if head[3] & 2:  # header crc
                f.read(2)
            start = f.tell()
        self._offsets = []
        for size in sizes:
            self._offsets.append((start, size))
            start += size

    def _chunk(self, f, number):
        data = self._chunk_cache.get(number)
        if data is None:
            start, size = self._offsets[number]
            f.seek(start)
            data = zlib.decompressobj(-15).decompress(f.read(size))
            if len(self._chunk_cache) > 8:
                self._chunk_cache.clear()
            self._chunk_cache[number] = data
        return data

    def read(self, offset, size):
        first = offset // self._chunk_len
        last = (offset + size - 1) // self._chunk_len
        with open(self._path, "rb") as f:
            data = b"".join(self._chunk(f, n) for n in range(first, last + 1))
        skip = offset - first * self._chunk_len
        return data[skip:skip + size]


class _SenseParser(HTMLParser):
    """Collect the translations: <div lang=..> outside of examples and cross references."""

    def __init__(self, target_lang):
        super().__init__(convert_charrefs=True)
        self._target = target_lang
        self.senses = []
        self._stack = []  # one flag per open div: True if its text is a sense
        self._skip = 0  # depth inside example divs
        self._buf = None

    def handle_starttag(self, tag, attrs):
        if tag == "br":
            return
        if tag != "div":
            return
        attrs = dict(attrs)
        if self._skip or "example" in (attrs.get("class") or ""):
            self._skip += 1
            self._stack.append(False)
            return
        is_sense = attrs.get("lang") == self._target
        self._stack.append(is_sense)
        if is_sense:
            self._buf = []

    def handle_endtag(self, tag):
        if tag != "div" or not self._stack:
            return
        is_sense = self._stack.pop()
        if self._skip:
            self._skip -= 1
        elif is_sense and self._buf is not None:
            text = " ".join("".join(self._buf).split())
            if text:
                self.senses.append(text)
            self._buf = None

    def handle_data(self, data):
        if self._buf is not None and not self._skip:
            self._buf.append(data)


def parse_senses(html, target_lang):
    parser = _SenseParser(target_lang)
    parser.feed(html)
    return parser.senses


class Dictionary:
    def __init__(self, ifo_path, cache_dir=None):
        self.ifo_path = ifo_path
        self.info = read_ifo(ifo_path)
        base = os.path.splitext(ifo_path)[0]
        self.name = self.info.get("bookname", os.path.basename(base))
        self._idx_path = base + ".idx.gz" if os.path.exists(base + ".idx.gz") else base + ".idx"
        self._dict = DictZip(base + ".dict.dz")
        self._wide = self.info.get("idxoffsetbits") == "64"
        # "eng-deu" -> read German senses. Fall back to any lang if the name has no pair.
        stem = os.path.basename(base)
        pair = stem.split("-")
        self.target_lang = _LANG_CODES.get(pair[1]) if len(pair) == 2 else None
        self.label = "%s→%s" % tuple(_LANG_CODES.get(p, p) for p in pair) if len(pair) == 2 else self.name
        self._load(cache_dir)

    def _cache_path(self, cache_dir):
        stem = os.path.splitext(os.path.basename(self.ifo_path))[0]
        return os.path.join(cache_dir, "stardict_%s.pickle" % stem)

    def _load(self, cache_dir):
        stat = os.stat(self._idx_path)
        stamp = (CACHE_VERSION, self._idx_path, stat.st_mtime_ns, stat.st_size)
        if cache_dir:
            try:
                with open(self._cache_path(cache_dir), "rb") as f:
                    cached = pickle.load(f)
                if cached[0] == stamp:
                    self._keys, self._words, self._offsets, self._sizes = cached[1:]
                    self._build_buckets()
                    return
            except (OSError, pickle.UnpicklingError, EOFError):
                pass
        self._parse_index()
        self._build_buckets()
        if cache_dir:
            os.makedirs(cache_dir, exist_ok=True)
            with open(self._cache_path(cache_dir), "wb") as f:
                pickle.dump((stamp, self._keys, self._words, self._offsets, self._sizes),
                            f, pickle.HIGHEST_PROTOCOL)

    def _parse_index(self):
        opener = gzip.open if self._idx_path.endswith(".gz") else open
        with opener(self._idx_path, "rb") as f:
            data = f.read()
        fmt = ">QI" if self._wide else ">II"
        step = struct.calcsize(fmt)
        entries = []
        pos = 0
        find = data.find
        while pos < len(data):
            end = find(b"\0", pos)
            word = data[pos:end].decode("utf-8", "replace")
            offset, size = struct.unpack_from(fmt, data, end + 1)
            pos = end + 1 + step
            key = normalize(word)
            entries.append((key, word, offset, size))
        entries.sort(key=lambda e: e[0])
        self._keys = [e[0] for e in entries]
        self._words = [e[1] for e in entries]
        self._offsets = [e[2] for e in entries]
        self._sizes = [e[3] for e in entries]

    def _build_buckets(self):
        # Fuzzy search only looks at single words of similar length with the same first letter.
        buckets = {}
        for i, key in enumerate(self._keys):
            if key and " " not in key:
                buckets.setdefault((len(key), key[0]), []).append(i)
        self._buckets = buckets

    def __len__(self):
        return len(self._keys)

    def lookup(self, query, limit):
        """Return up to `limit` (rank, index) pairs. Lower rank is better."""
        keys = self._keys
        lo = bisect.bisect_left(keys, query)
        hi = bisect.bisect_left(keys, query + "￿", lo)
        hits = []
        for i in range(lo, hi):
            rank = (0 if keys[i] == query else 1, len(keys[i]) - len(query))
            hits.append((rank, i))
        if len(hits) > limit:
            hits.sort()
            hits = hits[:limit]
        return hits

    def fuzzy(self, query, max_dist, limit):
        hits = []
        n = len(query)
        for length in range(max(1, n - max_dist), n + max_dist + 1):
            for i in self._buckets.get((length, query[0]), ()):
                d = bounded_distance(query, self._keys[i], max_dist)
                if d is not None:
                    hits.append(((2 + d, abs(length - n)), i))
        hits.sort()
        return hits[:limit]

    def senses(self, index):
        raw = self._dict.read(self._offsets[index], self._sizes[index])
        html = raw.decode("utf-8", "replace")
        if self.target_lang:
            return parse_senses(html, self.target_lang)
        return parse_senses(html, None)

    def word(self, index):
        return self._words[index]


_LANG_CODES = {"eng": "en", "deu": "de", "fra": "fr", "spa": "es", "ita": "it", "nld": "nl"}


def bounded_distance(a, b, limit):
    """Damerau-Levenshtein (adjacent swaps count 1). None if larger than `limit`."""
    if abs(len(a) - len(b)) > limit:
        return None
    prev2 = None
    prev = list(range(len(b) + 1))
    for i in range(1, len(a) + 1):
        cur = [i] + [0] * len(b)
        row_min = i
        for j in range(1, len(b) + 1):
            cost = 0 if a[i - 1] == b[j - 1] else 1
            v = min(prev[j] + 1, cur[j - 1] + 1, prev[j - 1] + cost)
            if i > 1 and j > 1 and a[i - 1] == b[j - 2] and a[i - 2] == b[j - 1]:
                v = min(v, prev2[j - 2] + 1)
            cur[j] = v
            if v < row_min:
                row_min = v
        if row_min > limit:
            return None
        prev2, prev = prev, cur
    return prev[-1] if prev[-1] <= limit else None


class Searcher:
    def __init__(self, dictionaries):
        self.dictionaries = dictionaries

    def search(self, query, max_rows=30, fuzzy_below=5, max_dist=2):
        """Return a list of (label, headword, translation) rows."""
        query = normalize(query.strip())
        if not query:
            return []
        hits = []
        for d in self.dictionaries:
            hits += [(rank, d, i) for rank, i in d.lookup(query, max_rows)]
        if len(hits) < fuzzy_below:
            for d in self.dictionaries:
                hits += [(rank, d, i) for rank, i in d.fuzzy(query, max_dist, max_rows)]
        hits.sort(key=lambda h: h[0])
        rows = []
        for _, d, i in hits:
            for sense in d.senses(i):
                rows.append((d.label, d.word(i), sense))
            if len(rows) >= max_rows:
                break
        return rows[:max_rows]
