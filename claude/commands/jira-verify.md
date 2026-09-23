# Jira Ticket — Progress Verification

Check whether a Jira ticket's acceptance criteria and subtasks are actually done and implemented, and report the gaps.

**Usage:** `/jira-verify <TICKET-ID>`

---

## Instructions

The argument `$ARGUMENTS` contains the Jira ticket ID (e.g. `ABC-123`). If empty, ask the user for it.

---

### Step 1 — Authenticate with Jira (if needed)

Use ToolSearch with query `+jira` to check available Jira MCP tools. If only `mcp__jira__authenticate` and `mcp__jira__complete_authentication` are present, the session is not authenticated:

1. Call `mcp__jira__authenticate` and share the authorization URL with the user.
2. Ask the user to paste the full callback URL from the browser address bar.
3. Call `mcp__jira__complete_authentication` with the callback URL.
4. Run ToolSearch again to confirm the real tools are available.

---

### Step 2 — Fetch the ticket

Use the available Jira MCP tools (e.g. `mcp__jira__get_issue` or similar) to fetch the ticket identified by `$ARGUMENTS`. Retrieve at minimum:

- Summary / title, status, issue type
- Description and acceptance criteria
- Subtasks (with their own status each)
- Linked issues (blockers, related)
- Comments (last 5, for recent context — e.g. a prior `/jira-plan` output or review notes)

---

### Step 3 — Build the checklist of "done" signals

From the ticket, extract every discrete, checkable item:

- Each acceptance-criteria bullet
- Each subtask (its Jira status is one signal, but verify against code too — a subtask marked Done in Jira with no matching implementation is still a gap)
- Any explicit checklist in the description or comments

If the ticket has no acceptance criteria or subtasks and the description is too vague to derive checkable items, tell the user and ask them to clarify scope before continuing.

---

### Step 4 — Gather implementation evidence

Find what was actually built:

```
git log --all --oneline --grep="$ARGUMENTS" -i
git branch --show-current
git diff --stat <base>...HEAD
```

- If commits reference the ticket, inspect them (`git show <sha>`) to see what changed.
- If the current branch is the ticket's working branch, diff it against `main`/`master`.
- If no commits or diffs reference the ticket at all, say so plainly — don't guess at unrelated work.

---

### Step 5 — Cross-check each item

For every item from Step 3, decide a status by reading the actual diff/code, not just trusting Jira's subtask status:

| Status | Meaning |
| --- | --- |
| ✅ Done | Implementation found and matches the requirement |
| ⚠️ Partial | Some implementation found, but incomplete or diverges from the requirement |
| ❌ Missing | No implementation evidence found |
| ❓ Unverifiable | Can't be confirmed from code alone (e.g. manual QA, external config) — say what would confirm it |

Present as a table: `Item | Status | Evidence (file/commit) | Notes`.

---

### Step 6 — Report

Summarize:

- Overall completion (e.g. "6/8 items done, 1 partial, 1 missing")
- Blocking gaps — items that must be resolved before the ticket can be closed
- Non-blocking notes — nice-to-haves, follow-ups, unverifiable items

Keep it concise. Do not pad a clean result with filler; if everything is done, say so in one line.

---

### Step 7 — Offer to post findings (optional)

If the user wants this recorded on the ticket, draft a Jira-markup comment following the same style as `/jira-commit`'s comment step (factual, brief, use `{{monospace}}` for identifiers, no headers/bullets unless the gaps genuinely need a list). Show it and wait for explicit confirmation before posting via the Jira MCP tool.
