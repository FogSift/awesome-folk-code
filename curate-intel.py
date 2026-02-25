import json
import os

INTEL_FILE = "evidence/trending_artifacts.json"
MARKDOWN_FILE = "evidence/INTEL_REPORT.md"

def generate_report():
    if not os.path.exists(INTEL_FILE):
        return

    with open(INTEL_FILE, 'r') as f:
        data = json.load(f)

    report = [f"### 📡 Latest Intelligence [ {data['captured_at']} ]\n"]
    for repo in data['artifacts']:
        desc = repo['description'] if repo['description'] else "No description provided."
        report.append(f"* **[{repo['fullName']}]({repo['url']})** ")
        report.append(f"  _{desc}_ (⭐ {repo['stargazersCount']})\n")

    with open(MARKDOWN_FILE, 'w') as f:
        f.writelines(report)
    
    print(f"🏺 Intel Report curated at {MARKDOWN_FILE}")

if __name__ == "__main__":
    generate_report()
