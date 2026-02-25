import subprocess
import json
import re
import os

def generate_brief():
    artifact_path = "evidence/trending_artifacts.json"
    if not os.path.exists(artifact_path): return

    with open(artifact_path, "r") as f:
        data = json.load(f)
    
    artifacts = data.get('artifacts', [])
    briefs = []

    print(f"📡 Processing {len(artifacts)} artifacts...")

    for item in artifacts:
        repo_name = item.get('fullName')
        if not repo_name: continue

        print(f"📖 Sifting Vitals for {repo_name}...")
        
        # Metadata
        cmd = ["gh", "repo", "view", repo_name, "--json", "stargazerCount,forkCount,description,url"]
        result = subprocess.run(cmd, capture_output=True, text=True)
        if result.returncode != 0: continue
        
        s = json.loads(result.stdout)
        score = s['stargazerCount'] / (s['forkCount'] + 1)
        rank = "🔥 HIGH" if score > 20 else "🛠️ MED"

        # README for Task Extraction
        readme_cmd = ["gh", "repo", "view", repo_name, "--path", "README.md"]
        readme_result = subprocess.run(readme_cmd, capture_output=True, text=True)
        readme = readme_result.stdout if readme_result.returncode == 0 else s.get('description', "")
        
        install_match = re.search(r'(pip install \S+|npm install \S+|docker pull \S+)', readme)
        action = install_match.group(0) if install_match else "Check README for setup"

        briefs.append(f"REPO: {repo_name} [{rank}]\nTASK: {action}\nLINK: {s['url']}\n---")

    with open("evidence/tech_context.txt", "w") as f:
        f.write("\n".join(briefs))
    print(f"✅ Batch Tech Brief secured (Count: {len(briefs)})")

if __name__ == "__main__":
    generate_brief()
