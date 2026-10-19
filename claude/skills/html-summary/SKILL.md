---
name: html-summary
description: Generate a single-page, self-contained HTML summary of the current conversation, a git branch, or the working tree's uncommitted changes. Visual-first, minimal-text digest that favors charts/diagrams/timelines over prose. Use when the user asks to "summarize", "recap", or "visualize" the conversation, a branch, a diff, or a work tree, or asks for an "HTML summary" of any of those.
tools: Read, Bash, Grep, Glob, Write
---

# HTML Summary

Produce a single HTML file that lets someone grasp what happened at a glance —
stat tiles and a diagram do the work; sentences are a last resort.

## 1. Determine the target

One of: `conversation`, `branch`, `worktree`.

- If given explicitly in the invocation, use it.
- Otherwise infer: uncommitted changes present and user says "diff"/"working
  tree"/"uncommitted" → `worktree`. User says "this branch"/"PR"/"since main"
  → `branch`. No git angle, just "summarize what we did" → `conversation`.
- If still ambiguous, ask once rather than guessing.

## 2. Gather the raw facts (no interpretation yet)

**conversation** — re-read the session: what was asked, what was built/fixed,
decisions made, open questions. No tools needed beyond your own context.

**branch** — find the base (`main`/`master`) and run:
```sh
git log <base>..HEAD --oneline
git diff --stat <base>...HEAD
```

**worktree** — uncommitted state:
```sh
git status --porcelain
git diff --stat
```

Only use numbers you can derive from these outputs (or from the actual
conversation). Never invent metrics to fill a chart.

## 3. Distill before designing

Boil the raw facts down to:
- **One headline** — a single sentence stating the outcome.
- **3–6 stat tiles** — e.g. files changed, +/− lines, commit count, duration.
- **One dominant visual** — a timeline of commits/turns, or a before/after
  flow, or a stacked bar of change-by-area. Pick whichever shape the facts
  actually have; don't force a chart type onto data that doesn't fit it.
- **Key points list** — at most 5 items, each under ~10 words. These are
  labels, not paragraphs.
- **Optional callout** — a follow-up/risk, only if one genuinely exists.

If you can't fill a section with real content, cut the section — an empty
tile is worse than no tile.

## 4. Build the HTML

- Single file, everything inlined (`<style>` in `<head>`, no external CDNs —
  it must open offline, straight from disk).
- Prefer static inline SVG for charts/diagrams over JS-driven rendering; add
  `<script>` only if a static SVG genuinely can't express the visual.
- Support both color schemes via `prefers-color-scheme` — don't assume light
  mode.
- For palette, contrast, and chart-type choice, follow the `dataviz` skill's
  method (form heuristic + color formula) rather than picking colors ad hoc.
- Layout: header (title + one-line headline) → stat-tile row → the one
  dominant visual → key-points list → optional footer with branch/date/commit
  metadata. In that order, top to bottom, no sidebars or tabs.
- Word budget: if the total visible text on the page would take more than
  ~20 seconds to read, cut it further.

## 5. Save and report

Write to `./<target>-summary-<YYYYMMDD-HHMM>.html` in the current directory
(or wherever the user specifies). Report the file path — do not try to open a
browser yourself.

## Avoid

- Long paragraphs or multi-sentence explanations anywhere on the page.
- Generic dashboard filler (progress rings with no real progress metric,
  decorative icons that don't map to data).
- External fonts/scripts/images — the file must be portable and offline-safe.
- Fabricating stats not backed by actual git output or conversation content.
