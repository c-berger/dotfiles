---
name: html-summary
description: Generate a visual, self-contained one-page HTML summary of the conversation, a git branch, or the uncommitted changes. Use when asked to "summarize", "recap", or "visualize" any of these, or for an "HTML summary".
allowed-tools: Read, Bash, Grep, Glob, Write
---

# HTML Summary

Produce one HTML file that can be grasped at a glance: stat tiles and a
diagram do the work, sentences are a last resort.

## 1. Pick the target

`conversation`, `branch`, or `worktree`. Use the one given in the request.
Otherwise infer it: "diff"/"uncommitted"/"working tree" → `worktree`;
"this branch"/"PR"/"since main" → `branch`; "what we did" → `conversation`.
If still unclear, ask once.

## 2. Gather facts

- **conversation:** what was asked, built or fixed, decisions, open questions.
- **branch:** `git log <base>..HEAD --oneline` and `git diff --stat <base>...HEAD`
  (`<base>` is `main` or `master`).
- **worktree:** `git status --porcelain` and `git diff --stat`.

Use only numbers from these outputs or the conversation. Never invent metrics.

## 3. Distill

- One headline sentence stating the outcome.
- 3–6 stat tiles (files changed, +/− lines, commits, duration, ...).
- One dominant visual in the shape the facts actually have: commit/turn
  timeline, before/after flow, or change-by-area bars.
- At most 5 key points, under ~10 words each.
- An optional callout for a real follow-up or risk.

Drop any section you can't fill with real content.

## 4. Build

- Single file, everything inlined, no external fonts/scripts/images; it must
  open offline from disk.
- Static inline SVG for visuals; `<script>` only if SVG can't express it.
- Support light and dark via `prefers-color-scheme`.
- Choose colors and chart types with the `dataviz` skill.
- Layout top to bottom: title + headline → stat tiles → visual → key points →
  footer (branch, date, commit). No sidebars or tabs.
- All visible text should be readable in about 20 seconds; no paragraphs.

## 5. Save

Write `<target>-summary-<YYYYMMDD-HHMM>.html` to the system temp directory
unless the user names a path, so the repo's `git status` stays clean. Report
the full path; don't open a browser.
