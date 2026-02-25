import subprocess
import json
import os
import re

INTEL_FILE = "evidence/trending_artifacts.json"
TEMP_BRIEF = "evidence/tech_context.tmp"
FINAL_BRIEF = "evidence/tech_context.txt"

def generate_actionable_brief():
    if not os.path.exists(INTEL_FILE): return
        
    with open(INTEL_FILE, 'r') as f:
        data = json.load(f)
        artifacts = data.get('artifacts', data.get('repos', []))
        if not artifacts: return
        repo_name = artifacts[0]['fullName']

    print(f"📖 Sifting Vitals for {repo_name}...")
    
    cmd = ["gh", "repo", "view", repo_name, "--json", "stargazersCount,openIssuesCount,description,url,readme"]
    result = subprocess.run(cmd, capture_output=True, text=True)
    
    if result.returncode == 0:
        s = json.loads(result.stdout)
        score = s['stargazersCount'] / (s['openIssuesCount'] + 1)
        rank = "🔥 HIGH" if score > 50 else "🛠️ MED"
        
        readme = s.get('readme', "")
        install_match = re.search(r'(pip install \S+|npm install \S+|docker pull \S+)', readme)
        action = install_match.group(0) if install_match else "Check README for setup"

        brief = [
            f"REPO: {repo_name} [{rank}]",
            f"TASK: {action}",
            f"LINK: {s['url']}"
        ]
        
        # Atomic Write Pattern
        with open(TEMP_BRIEF, "w") as f:
            f.write("\n".join(brief))
        os.replace(TEMP_BRIEF, FINAL_BRIEF)
        print(f"✅ Actionable Brief Secured.")

if __name__ == "__main__":
    generate_actionable_brief()
