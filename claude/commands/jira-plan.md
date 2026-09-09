# Jira Ticket Review & Solution Planning

Review a Jira ticket and produce a concrete implementation plan.

**Usage:** `/jira-plan <TICKET-ID>`

---

## Instructions

The argument `$ARGUMENTS` contains the Jira ticket ID (e.g. `ABC-123`). If it is empty, ask the user for the ticket ID before proceeding.

### Step 1 — Authenticate

Use ToolSearch with query `+jira` to discover available Jira MCP tools. If the only tools present are `mcp__jira__authenticate` and `mcp__jira__complete_authentication`, the session is not yet authenticated:

1. Call `mcp__jira__authenticate` to start the OAuth flow and get the authorization URL.
2. Tell the user to open the URL in their browser and authorize.
3. Ask the user to paste the full callback URL from the browser address bar after authorization.
4. Call `mcp__jira__complete_authentication` with that callback URL.
5. Call ToolSearch again — the real Jira tools should now be available.

### Step 2 — Fetch the ticket

Use the available Jira MCP tools (e.g. `mcp__jira__get_issue` or similar) to fetch the ticket identified by `$ARGUMENTS`. Retrieve at minimum:

- Summary / title
- Description
- Acceptance criteria (if present)
- Issue type, priority, status
- Labels, components, fix version
- Linked issues (blockers, sub-tasks, related)
- Comments (last 5, to capture recent context)

### Step 3 — Assess completeness

Read the ticket carefully. If anything is unclear or missing that would affect the implementation, ask the user targeted questions — one group of related questions at a time, not a long list. Typical gaps:

- Ambiguous acceptance criteria or scope boundaries
- Missing context on affected subsystems or data flows
- No reproduction steps for bugs
- Unclear non-functional requirements (perf, security, compatibility)
- Dependencies not mentioned in linked issues

Wait for the user's answers before proceeding.

### Step 4 — Draft the solution plan

Once you have enough information, produce a structured plan using this template:

---

## Solution Plan: `<TICKET-ID>` — `<Summary>`

### Problem / Goal

One paragraph: what is broken or missing, and what success looks like.

### Approach

The chosen strategy and why. Call out any alternatives considered and why they were rejected.

### Implementation Steps

Numbered list. Each step should be concrete enough to be a single commit or PR. Include:

- Which file(s) / component(s) to touch
- What to change and why
- Any migration or data-change steps

### Testing

How to verify the fix or feature works. Include unit tests, integration tests, and manual verification steps.

### Open Questions / Risks

Anything that needs confirmation before or during implementation.

---

Keep the plan concise. Do not pad it. If the ticket is trivial, the plan can be a few sentences.
