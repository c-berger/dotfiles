# Jira Ticket — Branch, Commit & Comment

Create a feature branch (if needed), commit staged changes, then post a Jira comment with a link to the commit.

**Usage:** `/jira-commit <TICKET-ID>`

---

## Instructions

The argument `$ARGUMENTS` contains the Jira ticket ID (e.g. `ABC-123`). If empty, ask the user for it.

---

### Step 1 — Ensure a feature branch exists

Run `git branch --show-current` to get the current branch name.

- If the branch name already starts with `$ARGUMENTS` (case-insensitive), stay on it.
- Otherwise, propose a branch name in the format `TICKET-ID-short-description` where `short-description` is a 3–5 word kebab-case summary derived from the ticket title or the work done. Ask the user to confirm or adjust the name, then run:

```
git checkout -b <branch-name>
```

---

### Step 2 — Inspect changes

Run `git status` and `git diff --stat HEAD` to see what is staged and unstaged.

- If nothing is staged and there are unstaged changes, ask the user which files to include and stage them.
- If there is nothing to commit at all, tell the user and stop.
- Show a brief summary of what will be committed before proceeding.

---

### Step 3 — Compose the commit message

Follow the **Conventional Commits** format:

```
<type>[optional scope]: <short summary>

[optional body — max 1–2 sentences]
```

**Type selection:**

| Situation                    | Type       |
| ---------------------------- | ---------- |
| Bug fix                      | `FIX`      |
| New feature                  | `ADD`      |
| Refactor, no behavior change | `REFACTOR` |
| Tests only                   | `TEST`     |
| Build / CI                   | `CI`       |
| Docs only                    | `DOCS`     |

Rules:

- Summary line ≤ 72 characters, imperative mood, no trailing period.
- Body only if there is genuinely non-obvious context. One or two sentences maximum — never a list.
- Add `[TICKET-ID]` at the end of the summary line (e.g. `FIX: bug fixed [ABC-123]`).
- The optional scope must be in uppercase (e.g. FIX: bug fixed [ABC-123]).

Draft the commit message, show it to the user, and wait for approval or edits before committing.

---

### Step 4 — Commit

Once the user approves the message, run:

```
git commit -m "$(cat <<'EOF'
<approved message>
EOF
)"
```

Then capture the commit SHA:

```
git rev-parse HEAD
```

---

### Step 5 — Build the remote commit URL

Run the following to get the remote URL:

```
git remote get-url origin
```

Convert SSH remote URLs (`git@host:org/repo.git`) to HTTPS (`https://host/org/repo`).
Strip the trailing `.git` suffix.
Append `/commit/<SHA>` to form the full commit link.

Example result: `https://github.example.com/org/repo/commit/abc1234`

Ask the user to confirm the URL looks correct before proceeding (in case the remote host or path differs from expectations).

---

### Step 6 — Authenticate with Jira (if needed)

Use ToolSearch with query `+jira` to check available Jira MCP tools. If only `mcp__jira__authenticate` and `mcp__jira__complete_authentication` are present, the session is not authenticated:

1. Call `mcp__jira__authenticate` and share the authorization URL with the user.
2. Ask the user to paste the full callback URL from the browser address bar.
3. Call `mcp__jira__complete_authentication` with the callback URL.
4. Run ToolSearch again to confirm the real tools are available.

---

### Step 7 — Draft the Jira comment

Write the comment in **Jira markup language**. Keep it factual and brief.

Template:

```
[Short 1–2 sentence description of what was changed and why — plain English, no jargon.]

*Commit:* [<short-sha>|<full-commit-url>]
```

- `short-sha` = first 8 characters of the full SHA.
- Use `[label|url]` for hyperlinks (Jira markup syntax).
- Use `{{monospace}}` for branch names and code references.
- Do not add headers, bullets, or extra sections unless the change genuinely needs them.

Show the drafted comment to the user and wait for explicit confirmation ("yes", "looks good", "post it", etc.) before posting.

---

### Step 8 — Post the comment

Use the available Jira MCP tool (e.g. `mcp__jira__add_comment` or similar) to post the confirmed comment to the ticket identified by `$ARGUMENTS`.

Confirm to the user that the comment was posted successfully.
