# Keypirinha: a fast launcher for Windows (keypirinha.com)

import keypirinha as kp
import keypirinha_util as kpu
from .lib import stardict_core as core
import os.path
import threading
import traceback


class StarDict(kp.Plugin):
    """Translate words with local StarDict dictionaries"""
    CONFIG_SECTION_MAIN = "main"
    CONFIG_SECTION_DICT = "dictionary"

    DEFAULT_KEYWORD = "tr"
    DEFAULT_MAX_ROWS = 30

    RESULT_ITEMCAT = kp.ItemCategory.USER_BASE + 1

    def __init__(self):
        super().__init__()
        self.keyword = self.DEFAULT_KEYWORD
        self.max_rows = self.DEFAULT_MAX_ROWS
        self.paths = []
        self.searcher = None
        self.lock = threading.Lock()

    def on_start(self):
        self._read_config()
        # Index parsing takes seconds on a cold cache. Do it off the UI thread.
        threading.Thread(target=self._load, daemon=True).start()

    def on_catalog(self):
        self._read_config()
        self.set_catalog([self.create_item(
            category=kp.ItemCategory.KEYWORD,
            label=self.keyword,
            short_desc="Translate with local dictionaries",
            target=self.keyword,
            args_hint=kp.ItemArgsHint.REQUIRED,
            hit_hint=kp.ItemHitHint.NOARGS)])

    def on_suggest(self, user_input, items_chain):
        if not items_chain or items_chain[-1].category() != kp.ItemCategory.KEYWORD:
            return
        if not user_input.strip():
            return
        # Wait until the user stops typing
        if self.should_terminate(0.150):
            return
        if not self.lock.acquire(blocking=False):
            self.set_suggestions([self.create_error_item(
                label=user_input, short_desc="Dictionaries are still loading...")])
            return
        try:
            if self.searcher is None:
                self.set_suggestions([self.create_error_item(
                    label=user_input, short_desc="No dictionary loaded. See the Keypirinha console.")])
                return
            rows = self.searcher.search(user_input, max_rows=self.max_rows)
        except Exception:
            self.err("Search failed.")
            traceback.print_exc()
            return
        finally:
            self.lock.release()

        if self.should_terminate():
            return
        if not rows:
            self.set_suggestions([self.create_error_item(
                label=user_input, short_desc="No translation found")])
            return
        suggestions = [self.create_item(
            category=self.RESULT_ITEMCAT,
            label=translation,
            short_desc="{}  ({})".format(headword, direction),
            target=translation,
            args_hint=kp.ItemArgsHint.FORBIDDEN,
            hit_hint=kp.ItemHitHint.IGNORE) for direction, headword, translation in rows]
        self.set_suggestions(suggestions, kp.Match.ANY, kp.Sort.NONE)

    def on_execute(self, item, action):
        if item.category() == self.RESULT_ITEMCAT:
            kpu.set_clipboard(item.target())

    def on_events(self, flags):
        if flags & kp.Events.PACKCONFIG:
            self.on_start()

    def _load(self):
        with self.lock:
            cache_dir = self.get_package_cache_path(create=True)
            dictionaries = []
            for path in self.paths:
                try:
                    dictionaries.append(core.Dictionary(path, cache_dir))
                except Exception:
                    self.err("Cannot load dictionary", path)
                    traceback.print_exc()
            self.searcher = core.Searcher(dictionaries) if dictionaries else None
            self.info("Loaded {} dictionaries".format(len(dictionaries)))

    def _read_config(self):
        settings = self.load_settings()
        self.keyword = settings.get_stripped(
            "keyword", section=self.CONFIG_SECTION_MAIN, fallback=self.DEFAULT_KEYWORD)
        self.max_rows = settings.get_int(
            "max_rows", section=self.CONFIG_SECTION_MAIN, fallback=self.DEFAULT_MAX_ROWS, min=1, max=200)
        self.paths = []
        for section in settings.sections():
            if not section.lower().startswith(self.CONFIG_SECTION_DICT + "/"):
                continue
            if not settings.get_bool("enable", section=section, fallback=True):
                continue
            path = settings.get_stripped("path", section=section)
            if not path:
                self.warn('Missing "path" in section "{}"'.format(section))
                continue
            path = os.path.expandvars(os.path.expanduser(path))
            if not os.path.isfile(path):
                self.warn('File not found: "{}"'.format(path))
                continue
            self.paths.append(path)
