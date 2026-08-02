#!/usr/bin/env python3
"""
Automated GitHub Traffic Monitor & Report Generator for Obsidian
Fetches clone and view analytics from the GitHub API and persists historical data past the 14-day limit.
"""

import json
import os
import subprocess
import sys
from datetime import datetime
from pathlib import Path
import urllib.request

REPO_DEFAULT = "madhankumar866/cloud-engineering-vault"
HISTORY_FILE = Path(".github/traffic/history.json")
REPORT_FILE = Path("Inbox/Repository-Traffic-Report.md")


def get_api_data(endpoint: str) -> dict:
    repo = os.environ.get("GITHUB_REPOSITORY", REPO_DEFAULT)
    token = os.environ.get("GITHUB_TOKEN", os.environ.get("TRAFFIC_TOKEN", ""))
    url = f"https://api.github.com/repos/{repo}/traffic/{endpoint}"

    # When running locally (outside CI), prioritize gh CLI using clean_env() to leverage macOS keychain
    if not os.environ.get("CI") and shutil_which("gh"):
        try:
            cmd = ["gh", "api", f"/repos/{repo}/traffic/{endpoint}"]
            res = subprocess.run(cmd, capture_output=True, text=True, env=clean_env(), check=True)
            return json.loads(res.stdout)
        except Exception as e:
            print(f"[!] Local gh CLI fetch failed: {e}")

    # Fallback to standard HTTP request
    req = urllib.request.Request(url)
    req.add_header("Accept", "application/vnd.github+json")
    req.add_header("User-Agent", "Obsidian-Traffic-Monitor")
    if token:
        req.add_header("Authorization", f"Bearer {token}")

    try:
        with urllib.request.urlopen(req) as resp:
            return json.loads(resp.read().decode())
    except Exception as e:
        print(f"[!] HTTP request to {url} failed: {e}")
        return {}


def shutil_which(cmd: str) -> bool:
    import shutil
    return shutil.which(cmd) is not None


def clean_env():
    """Remove conflicting token environment variables when testing locally with gh CLI keyring."""
    env = os.environ.copy()
    if not os.environ.get("CI"):
        env.pop("GITHUB_TOKEN", None)
    return env


def merge_history(existing: list, new_items: list, key: str) -> list:
    """Merge new daily traffic timestamps into existing persistent records without duplicates."""
    data_map = {item["timestamp"][:10]: item for item in existing}
    for item in new_items:
        date_str = item["timestamp"][:10]
        # Overwrite/update existing day record or append brand new date
        data_map[date_str] = {
            "timestamp": item["timestamp"],
            "count": item["count"],
            "uniques": item["uniques"],
        }
    sorted_data = sorted(data_map.values(), key=lambda x: x["timestamp"])
    return sorted_data


def update_report(clones_list: list, views_list: list):
    """Render a clean Markdown dashboard for Obsidian Dataview compatibility."""
    total_clones = sum(item["count"] for item in clones_list)
    max_unique_cloners = max([item["uniques"] for item in clones_list] + [0])
    
    total_views = sum(item["count"] for item in views_list)
    max_unique_viewers = max([item["uniques"] for item in views_list] + [0])

    report_content = f"""---
tags:
  - devops/automation
  - review
status: completed
Repetition: rep/1
---
# 📈 Repository Traffic & Clone Analytics

This automated report tracks repository discoverability and retains historical GitHub traffic data beyond GitHub's default 14-day retention limit using `.github/workflows/traffic-monitor.yml`.

## 📊 All-Time Retained Summary
* **Total Recorded Clones:** {total_clones} *(Peak Unique Cloners in a single day: {max_unique_cloners})*
* **Total Recorded Views:** {total_views} *(Peak Unique Visitors in a single day: {max_unique_viewers})*
* **Last Updated:** {datetime.now().strftime('%Y-%m-%d %H:%M UTC')}

---

## 📥 Daily Clone History (Persistent Archive)

| Date | Total Clones | Unique Machines/Users |
|---|---|---|
"""
    for c in reversed(clones_list):
        date_str = c["timestamp"][:10]
        report_content += f"| {date_str} | **{c['count']}** | {c['uniques']} |\n"

    if not clones_list:
        report_content += "| *No clone traffic recorded yet* | 0 | 0 |\n"

    report_content += """
---

## 👀 Daily View History (Persistent Archive)

| Date | Total Page Views | Unique Visitors |
|---|---|---|
"""
    for v in reversed(views_list):
        date_str = v["timestamp"][:10]
        report_content += f"| {date_str} | **{v['count']}** | {v['uniques']} |\n"

    if not views_list:
        report_content += "| *No view traffic recorded yet* | 0 | 0 |\n"

    report_content += """
---
## 🏗️ Architecture & FinOps Notes
* **Why this exists:** GitHub REST APIs only retain traffic stats for 14 days. By storing historical arrays in `.github/traffic/history.json`, this setup persists portfolio engagement statistics indefinitely at **$0 FinOps cost** via GitHub Actions schedules.
* **Script Source:** [update_traffic.py](file:///.github/scripts/update_traffic.py)
"""
    REPORT_FILE.parent.mkdir(parents=True, exist_ok=True)
    REPORT_FILE.write_text(report_content, encoding="utf-8")
    print(f"[+] Successfully generated report at {REPORT_FILE}")


def main():
    HISTORY_FILE.parent.mkdir(parents=True, exist_ok=True)

    # 1. Load existing database
    if HISTORY_FILE.exists():
        try:
            with open(HISTORY_FILE, "r", encoding="utf-8") as f:
                db = json.load(f)
        except Exception as e:
            print(f"[!] Failed to read history file: {e}")
            db = {"clones": [], "views": []}
    else:
        db = {"clones": [], "views": []}

    # 2. Fetch fresh API analytics
    print("[*] Fetching clones data...")
    clones_res = get_api_data("clones")
    print("[*] Fetching views data...")
    views_res = get_api_data("views")

    new_clones = clones_res.get("clones", [])
    new_views = views_res.get("views", [])

    # 3. Merge without losing past days
    db["clones"] = merge_history(db.get("clones", []), new_clones, "clones")
    db["views"] = merge_history(db.get("views", []), new_views, "views")

    # 4. Save persistent JSON database
    with open(HISTORY_FILE, "w", encoding="utf-8") as f:
        json.dump(db, f, indent=2)
    print(f"[+] Saved updated historical analytics to {HISTORY_FILE}")

    # 5. Render markdown dashboard
    update_report(db["clones"], db["views"])


if __name__ == "__main__":
    main()
