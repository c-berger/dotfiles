---
description: Commit staged changes on a ticket branch and comment the commit link on the Jira ticket
argument-hint: <TICKET-ID>
disable-model-invocation: true
---

Ticket ID: `$ARGUMENTS` (e.g. `ABC-123`). Ask for it if empty.

If the Jira tools are unavailable, ask the user to authenticate via `/mcp`.

## 1. Branch

Check `git branch --show-current`. If it already starts with the ticket ID
(case-insensitive), stay on it. Otherwise propose `TICKET-ID-short-kebab-title`
(3–5 words), and after the user confirms run `git checkout -b <name>`.

## 2. Changes

Run `git status` and `git diff --stat HEAD`.

- Nothing to commit: say so and stop.
- Nothing staged: ask which files to stage.

## 3. Commit

Format: `TYPE: summary [TICKET-ID]`, e.g. `FIX: handle empty config [ABC-123]`

| Type       | Use for                      |
| ---------- | ---------------------------- |
| `ADD`      | New feature                  |
| `FIX`      | Bug fix                      |
| `REFACTOR` | Refactor, no behavior change |
| `TEST`     | Tests only                   |
| `CI`       | Build / CI                   |
| `DOCS`     | Docs only                    |

- Imperative mood, max 72 characters, no trailing period.
- Add a body (1–2 sentences, no lists) only for non-obvious context.

Show the message and commit only after the user approves it.

## 4. Jira comment

Build the commit URL from `git remote get-url origin` (SSH → HTTPS, strip
`.git`) plus `/commit/<SHA>`.

Draft the comment in Jira markup:

```
<1–2 plain sentences: what changed and why.>

*Commit:* [<first 8 chars of SHA>|<commit URL>]
```

Use `{{monospace}}` for branch names and code. Post it with
`mcp__jira__jira_add_comment` only after the user approves it.
