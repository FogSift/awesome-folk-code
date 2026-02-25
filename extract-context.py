import subprocess
import json
import os

INTEL_FILE = "evidence/trending_artifacts.json"
BRIEF_FILE = "evidence/tech_context.txt"

def generate_brief():
    if not os.path.exists(INTEL_FILE):
        return
        
    with open(INTEL_FILE, 'r') as f:
        data = json.load(f)
        artifacts = data.get('artifacts', data.get('repos', []))
        if not artifacts: return
        repo_name = artifacts[0]['fullName']

    print(f"📖 Sifting Vitals for {repo_name}...")
    
    cmd = ["gh", "repo", "view", repo_name, "--json", "stargazersCount,forkCount,openIssuesCount,description,url"]
    result = subprocess.run(cmd, capture_output=True, text=True)
    
    if result.returncode == 0:
        s = json.loads(result.stdout)
        
        # 🧪 Scoring Logic
        health_score = s['stargazersCount'] / (s['openIssuesCount'] + 1)
        status = "🔥 HIGH SIGNAL" if health_score > 50 else "🛠️ ACTIVE DEV" if health_score > 10 else "⚠️ UNSTABLE"

        brief = [
            f"NAME: {repo_name}",
            f"RANK: {status} (Score: {health_score:.1f})",
            f"DESC: {s['description'][:80]}...",
            f"LINK: {s['url']}"
        ]
        
        with open(BRIEF_FILE, "w") as f:
            f.write("\n".join(brief))
        print(f"✅ Research Brief Secured for {repo_name}")

if __name__ == "__main__":
    generate_brief()
