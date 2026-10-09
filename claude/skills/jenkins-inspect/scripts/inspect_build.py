#!/usr/bin/env python3
"""
Finds the Jenkins multibranch job/build matching the current repo + branch
and reports its status, pipeline stages, and (on failure) relevant console
output, as JSON on stdout.

Auth and server are read from the JENKINS_URL / JENKINS_USER_ID /
JENKINS_API_TOKEN environment variables (same ones used for jenkins-cli.jar).
Everything this script does is a GET request, so no CSRF crumb is needed.
"""
import argparse
import base64
import json
import os
import re
import subprocess
import sys
import urllib.error
import urllib.parse
import urllib.request

MULTIBRANCH_CLASS = "WorkflowMultiBranchProject"
FOLDER_CLASSES = ("Folder", "OrganizationFolder")


def jenkins_env():
    missing = [v for v in ("JENKINS_URL", "JENKINS_USER_ID", "JENKINS_API_TOKEN") if not os.environ.get(v)]
    if missing:
        fail(f"Missing environment variable(s): {', '.join(missing)}")
    url = os.environ["JENKINS_URL"]
    return url if url.endswith("/") else url + "/", os.environ["JENKINS_USER_ID"], os.environ["JENKINS_API_TOKEN"]


def fail(message, **extra):
    print(json.dumps({"status": "error", "message": message, **extra}, indent=2))
    sys.exit(1)


def http_get(url, user, token, as_json=True):
    req = urllib.request.Request(url)
    auth = base64.b64encode(f"{user}:{token}".encode()).decode()
    req.add_header("Authorization", f"Basic {auth}")
    try:
        with urllib.request.urlopen(req, timeout=20) as r:
            body = r.read()
    except urllib.error.HTTPError as e:
        fail(f"HTTP {e.code} fetching {url}", detail=e.read().decode(errors="replace")[:500])
    return json.loads(body) if as_json else body.decode(errors="replace")


def run_git(repo_root, *args):
    result = subprocess.run(["git", "-C", repo_root, *args], capture_output=True, text=True)
    return result.stdout.strip() if result.returncode == 0 else None


def repo_context(repo_root_arg):
    repo_root = repo_root_arg or run_git(".", "rev-parse", "--show-toplevel") or os.getcwd()
    branch = run_git(repo_root, "rev-parse", "--abbrev-ref", "HEAD")
    sha = run_git(repo_root, "rev-parse", "HEAD")
    remote = run_git(repo_root, "remote", "get-url", "origin") or ""
    name = re.sub(r"\.git$", "", remote.rstrip("/").split("/")[-1]) if remote else os.path.basename(repo_root)
    return repo_root, name, branch, sha


def find_jenkinsfiles(repo_root):
    found = []
    for dirpath, dirnames, filenames in os.walk(repo_root):
        dirnames[:] = [d for d in dirnames if d != ".git"]
        for f in filenames:
            if f == "Jenkinsfile" or f.startswith("Jenkinsfile.") or f.endswith(".groovy"):
                found.append(os.path.relpath(os.path.join(dirpath, f), repo_root).replace("\\", "/"))
    return sorted(found)


def normalize(name):
    return re.sub(r"[^a-z0-9]", "", name.lower())


def find_multibranch_candidates(base_url, user, token, repo_name, max_depth):
    norm_repo = normalize(repo_name)
    candidates = []
    queue = [(base_url, 0)]
    seen = set()
    while queue:
        folder_url, depth = queue.pop(0)
        if folder_url in seen:
            continue
        seen.add(folder_url)
        data = http_get(folder_url + "api/json?tree=jobs[name,url,_class]", user, token)
        for job in data.get("jobs", []):
            cls = job.get("_class", "")
            if MULTIBRANCH_CLASS in cls and normalize(job["name"]) == norm_repo:
                candidates.append(job)
            elif any(fc in cls for fc in FOLDER_CLASSES) and depth < max_depth:
                queue.append((job["url"], depth + 1))
    return candidates


def script_path_for(job_url, user, token):
    xml = http_get(job_url + "config.xml", user, token, as_json=False)
    m = re.search(r"<scriptPath>(.*?)</scriptPath>", xml)
    return m.group(1) if m else "Jenkinsfile"


def pick_job(candidates, jenkinsfiles, user, token):
    if len(candidates) <= 1:
        return candidates[0] if candidates else None
    for c in candidates:
        c["scriptPath"] = script_path_for(c["url"], user, token)
    matches = [c for c in candidates if c["scriptPath"] in jenkinsfiles]
    return matches[0] if len(matches) == 1 else None


def find_branch_job(job_url, branch, user, token):
    data = http_get(job_url + "api/json?tree=jobs[name,url]", user, token)
    encoded = branch.replace("/", "%2F")
    for j in data.get("jobs", []):
        if j["name"] in (branch, encoded):
            return j
    return None


def extract_built_sha(actions, branch):
    sha = None
    for a in actions:
        rev = a.get("lastBuiltRevision") if isinstance(a, dict) else None
        if not rev:
            continue
        sha = rev.get("SHA1", sha)
        for b in rev.get("branch", []):
            if b.get("name", "").endswith(branch):
                return b.get("SHA1")
    return sha


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--repo-root")
    ap.add_argument("--branch")
    ap.add_argument("--build", default="lastBuild")
    ap.add_argument("--job-url", help="Skip discovery, use this multibranch job URL directly")
    ap.add_argument("--max-depth", type=int, default=4)
    args = ap.parse_args()

    base_url, user, token = jenkins_env()
    repo_root, repo_name, branch, sha = repo_context(args.repo_root)
    branch = args.branch or branch
    if not branch:
        fail("Could not determine current git branch", repo_root=repo_root)
    jenkinsfiles = find_jenkinsfiles(repo_root)

    if args.job_url:
        job = {"name": repo_name, "url": args.job_url}
    else:
        candidates = find_multibranch_candidates(base_url, user, token, repo_name, args.max_depth)
        if not candidates:
            fail(f"No multibranch Jenkins job found matching repo name '{repo_name}'",
                 repo_name=repo_name, jenkinsfiles=jenkinsfiles)
        job = pick_job(candidates, jenkinsfiles, user, token)
        if job is None:
            print(json.dumps({
                "status": "ambiguous_job",
                "repo_name": repo_name,
                "jenkinsfiles": jenkinsfiles,
                "candidates": [{"name": c["name"], "url": c["url"]} for c in candidates],
            }, indent=2))
            sys.exit(0)

    branch_job = find_branch_job(job["url"], branch, user, token)
    if branch_job is None:
        available = [j["name"] for j in http_get(job["url"] + "api/json?tree=jobs[name]", user, token).get("jobs", [])]
        print(json.dumps({
            "status": "no_branch_job",
            "job_name": job["name"],
            "job_url": job["url"],
            "branch": branch,
            "available_branches": available,
        }, indent=2))
        sys.exit(0)

    build_url = f"{branch_job['url']}{args.build}/"
    build = http_get(
        build_url + "api/json?tree=number,result,building,url,timestamp,actions[lastBuiltRevision[SHA1,branch[name,SHA1]]]",
        user, token,
    )
    built_sha = extract_built_sha(build.get("actions", []), branch)

    stages = []
    try:
        wf = http_get(build_url + "wfapi/describe", user, token)
        stages = [{"name": s["name"], "status": s["status"], "durationMillis": s.get("durationMillis")}
                  for s in wf.get("stages", [])]
    except SystemExit:
        stages = []

    result = build.get("result")
    error_lines = []
    console_tail = []
    if result not in ("SUCCESS", None) or any(s["status"] not in ("SUCCESS", "NOT_EXECUTED") for s in stages):
        console = http_get(build_url + "consoleText", user, token, as_json=False)
        lines = console.splitlines()
        console_tail = lines[-60:]
        error_lines = [l for l in lines if re.search(r"error|exception|failed|fatal", l, re.I)][-25:]

    print(json.dumps({
        "status": "ok",
        "repo_name": repo_name,
        "branch": branch,
        "local_sha": sha,
        "jenkinsfiles": jenkinsfiles,
        "job_name": job["name"],
        "job_url": job["url"],
        "branch_job_url": branch_job["url"],
        "build_number": build.get("number"),
        "build_url": build.get("url", build_url),
        "building": build.get("building"),
        "result": result,
        "built_sha": built_sha,
        "sha_matches_local": (built_sha == sha) if built_sha else None,
        "stages": stages,
        "error_lines": error_lines,
        "console_tail": console_tail,
    }, indent=2))


if __name__ == "__main__":
    main()
