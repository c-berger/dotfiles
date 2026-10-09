---
name: jenkins-inspect
description: Inspect the Jenkins pipeline build for the current repo/branch (found via Jenkinsfile/*.groovy files) and summarize failures. Use when asked to check CI status, investigate a failing Jenkins build, or "why did the pipeline fail".
---

# Jenkins pipeline inspection

Finds the Jenkins multibranch job that corresponds to the current repository
(by matching its name against the Jenkinsfile(s) found in the repo) and the
sub-job for the current git branch, then reports build result, per-stage
status, and — on failure — the relevant console output.

Server/auth come from environment variables that are expected to already be
set: `JENKINS_URL`, `JENKINS_USER_ID`, `JENKINS_API_TOKEN`. If any are
missing, tell the user to set them rather than trying to work around it —
don't prompt for credentials interactively or hardcode a token.

Note: `jenkins-cli.jar` / SSH CLI access do not work against this instance
(the reverse proxy in front of it rejects the required WebSocket upgrade, and
SSH CLI isn't enabled). Everything here goes through the plain REST API
instead, which works fine.

## Usage

Run the bundled script from the repo in question:

```sh
python3 "<skill_dir>/scripts/inspect_build.py"
```

It auto-detects: the repo root (`git rev-parse --show-toplevel`), repo name
(from the `origin` remote), current branch, current commit SHA, and any
`Jenkinsfile`/`Jenkinsfile.*`/`*.groovy` files in the tree. It then:

1. Searches Jenkins (breadth-first over folders, depth limited) for a
   `WorkflowMultiBranchProject` whose name matches the repo name.
2. If more than one match exists, disambiguates using each candidate's
   `scriptPath` (from its `config.xml`) against the Jenkinsfiles found in
   step 0 — if that's still ambiguous, it reports the candidates instead of
   guessing.
3. Finds the branch's sub-job (branch names containing `/` are stored with
   `/` replaced by `%2F`).
4. Fetches the build (`lastBuild` by default — pass `--build <n>` for a
   specific one), its per-stage status (`wfapi/describe`), and, if the
   result isn't a clean `SUCCESS`, the console log tail plus lines matching
   `error|exception|failed|fatal`.

Output is JSON on stdout with a top-level `status` field:

- `ok` — full report: `result`, `stages[]`, `error_lines[]`, `console_tail[]`,
  `build_url`, `sha_matches_local` (whether the build ran the commit you
  currently have checked out, useful to flag if it's stale).
- `ambiguous_job` — multiple candidate Jenkins jobs matched the repo name;
  shows `candidates[]`. Ask the user which one, then re-run with
  `--job-url <url>`.
- `no_branch_job` — the repo's job exists but has no sub-job for the current
  branch (e.g. never built); shows `available_branches[]`.
- `error` — e.g. missing env vars, repo has no Jenkinsfile match found, HTTP
  failure. Report `message` to the user directly, don't retry blindly.

Useful flags: `--branch <name>` to check a branch other than the current
one, `--repo-root <path>` if not running from inside the repo, `--job-url`
to skip discovery once you know the right job.

## Reporting to the user

Don't just dump the JSON. Summarize:
- Build result and number, and whether it matches the locally checked-out
  commit (`sha_matches_local`).
- Which stage(s) failed (from `stages`), not just the overall result.
- A short excerpt from `error_lines` / `console_tail` — the actual cause,
  not the whole log.
- The `build_url` so the user can open it directly if they want more detail.
