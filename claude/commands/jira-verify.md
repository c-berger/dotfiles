---
description: Check whether a Jira ticket's acceptance criteria and subtasks are really implemented
argument-hint: <TICKET-ID>
---

Ticket ID: `$ARGUMENTS` (e.g. `ABC-123`). Ask for it if empty.

If the Jira tools are unavailable, ask the user to authenticate via `/mcp`.

## 1. Fetch the ticket

Use `mcp__jira__jira_get_issue` for summary, status, description, acceptance
criteria, subtasks (with their status), and linked issues. Use
`mcp__jira__jira_get_comments` for the latest comments (e.g. a prior
`/jira-plan` or review notes).

## 2. List what must be done

Collect every checkable item: each acceptance criterion, each subtask, and any
checklist in the description or comments. If the ticket is too vague to
derive items, say so and ask the user to clarify scope.

## 3. Find the implementation

```sh
git log --all --oneline -i --grep="$ARGUMENTS"
git diff --stat main...HEAD   # or master
```

Inspect the matching commits with `git show`. If nothing references the
ticket, say so plainly instead of guessing at unrelated work.

## 4. Check each item

Judge by the actual code, not by Jira status: a subtask marked Done with no
matching change is still a gap.

| Status          | Meaning                                                |
| --------------- | ------------------------------------------------------ |
| ✅ Done         | Implemented and matches the requirement                |
| ⚠️ Partial      | Incomplete or diverges from the requirement            |
| ❌ Missing      | No implementation found                                |
| ❓ Unverifiable | Not provable from code (manual QA, config); say how to confirm |

## 5. Report

Show a table (`Item | Status | Evidence | Notes`), then:

- Totals, e.g. "6/8 done, 1 partial, 1 missing".
- Blocking gaps that prevent closing the ticket.
- Non-blocking notes.

If everything is done, say so in one line.

If the user wants the result on the ticket, draft a brief Jira-markup comment
(use `{{monospace}}` for identifiers, no headers) and post it with
`mcp__jira__jira_add_comment` only after the user approves it.
