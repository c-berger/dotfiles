---
description: Review a Jira ticket and draft an implementation plan (read-only)
argument-hint: <TICKET-ID>
---

Ticket ID: `$ARGUMENTS` (e.g. `ABC-123`). Ask for it if empty.

This command is read-only: do not edit files or touch the ticket.

If the Jira tools are unavailable, ask the user to authenticate via `/mcp`.

## 1. Fetch the ticket

Use `mcp__jira__jira_get_issue` for summary, description, acceptance
criteria, type, status, and linked issues. Use `mcp__jira__jira_get_comments`
for the latest comments.

## 2. Clarify

If something that affects the implementation is unclear (scope, acceptance
criteria, repro steps, non-functional requirements, dependencies), ask one
group of related questions and wait for the answers.

## 3. Look at the code

Search the repo for the areas the ticket touches, so the plan names real
files and functions.

## 4. Write the plan

Keep it short; for a trivial ticket a few sentences are enough.

```
## <TICKET-ID> — <summary>

**Goal:** what is broken or missing, and what done looks like.

**Approach:** the chosen strategy and why; alternatives only if rejected for
a non-obvious reason.

**Steps:** numbered, each small enough for one commit — files to change and
why, plus any migration steps.

**Testing:** automated and manual checks.

**Open questions / risks:** anything to confirm before or during the work.
```
