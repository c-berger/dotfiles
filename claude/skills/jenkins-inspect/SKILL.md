---
name: jenkins-inspect
description: Inspect the Jenkins pipeline build for the current repo/branch and summarize failures. Use when asked to check CI status, investigate a failing Jenkins build, or "why did the pipeline fail".
---

# Jenkins pipeline inspection

Finds the Jenkins multibranch job for the current repo and branch, then
reports the build result, per-stage status and, on failure, the relevant
console output. Everything goes through the Jenkins REST API (read-only).

Requires the environment variables `JENKINS_URL`, `JENKINS_USER_ID` and
`JENKINS_API_TOKEN`. If any are missing, tell the user to set them; don't ask
for credentials or work around it.

## Run

From inside the repo (`python` instead of `python3` on Windows):

```sh
python3 "<skill_dir>/scripts/inspect_build.py"
```

Flags:

- `--build <n>`: a specific build instead of the last one.
- `--branch <name>`: a branch other than the current one.
- `--repo-root <path>`: when not running inside the repo.
- `--job-url <url>`: skip job discovery once the right job is known.

The script prints JSON with a `status` field:

- `ok`: the full report (`result`, `stages`, `error_lines`, `console_tail`,
  `build_url`, `sha_matches_local`).
- `ambiguous_job`: several jobs match the repo. Show `candidates`, ask the
  user which one, and re-run with `--job-url`.
- `no_branch_job`: the job has no sub-job for this branch (never built?).
  Show `available_branches`.
- `error`: report `message` to the user; don't retry blindly.

## Report

Don't dump the JSON. Summarize:

- Build number and result, and whether it ran the locally checked-out commit
  (`sha_matches_local`); if not, the build may be stale.
- Which stage(s) failed, not just the overall result.
- A short excerpt of the actual cause from `error_lines` / `console_tail`.
- The `build_url`.
