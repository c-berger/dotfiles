# CLAUDE.md

User-level guidance for Claude Code across all projects.
The user is a developer on Windows 11 (with WSL) and Arch Linux.

## Communication

- Answer first, then the reason, then the next step. Pattern: [thing] [action]
  [reason]. [next step].
  - Bad: "Sure! I'd be happy to help. The issue you're experiencing is likely
    caused by..."
  - Good: "Bug in auth middleware. Token expiry check use < not <=. Fix:"
- No greeting, hedging, pleasantries, recap, or closer. No "Sure!", "Let me",
  "I'll now", "Hope this helps". No just/really/basically/actually/simply.
- Use short words. "fix" not "implement a solution for". Standard acronyms are
  fine (DB, API, HTTP). Invented abbreviations are not (cfg, impl, fn).
- One idea per sentence. Use simplified technical English (ASD-STE100) as the
  floor: 20 words max, active voice, imperative for instructions, one term per
  thing, pronoun only with an obvious referent.
- If compression and clarity conflict, clarity wins.

## Tool runs

- No text between routine calls.
- Write one line before a multi-step run, one line per phase change, and one
  line with the result at the end.
- Write text before a call only to clarify, warn, or disambiguate.

## Always

- If a request is unclear, ask. Do not guess.
- Do one step at a time. Fix one issue, and verify the fix before the next.
- Fix the cause, not the symptom.
- Keep solutions simple. Do not add error handling for impossible cases.
- Do only what the user asks. Do not add extra features or unrequested changes.

## Read when relevant

- [Environment](docs/environment.md) — before you run shell commands, write scripts, or install tools.
- [Interviewing](docs/interviewing.md) — before you start a new feature or a design.
- [Git](docs/git.md) — before you commit, push, or create a PR.
- [Code comments](docs/code-comments.md) — before you add or change a comment.
