import subprocess
import json
import re
import os

def generate_brief():
    artifact_path = "evidence/trending_artifacts.json"
    if not os.path.exists(artifact_path):
        print("❌ No trending artifacts found.")
        return

    with open(artifact_path, "r") as f:
        data = json.load(f)
    
    # Targeting: data['artifacts'][0]['fullName']
    try:
        repo_name = data['artifacts'][0]['fullName']
    except (KeyError, IndexError, TypeError):
        print("⚠️ Could not find 'fullName' in artifacts list.")
        return

    print(f"📡 Extracting context for: {repo_name}...")

    # 1. Get Metadata (Valid fields for GH CLI)
    cmd = ["gh", "repo", "view", repo_name, "--json", "stargazerCount,forkCount,url,description"]
    result = subprocess.run(cmd, capture_output=True, text=True)

    if result.returncode != 0:
        print(f"❌ GH CLI Error: {result.stderr}")
        return

    s = json.loads(result.stdout)

    # 2. Score calculation
    score = s['stargazerCount'] / (s['forkCount'] + 1)
    rank = "🔥 HIGH" if score > 20 else "🛠️ MED"

    # 3. Get README separately (Reliable method)
    readme_cmd = ["gh", "repo", "view", repo_name, "--path", "README.md"]
    readme_result = subprocess.run(readme_cmd, capture_output=True, text=True)
    readme = readme_result.stdout if readme_result.returncode == 0 else s.get('description', "")

    # 4. Extract Action (Regex for common install patterns)
    install_match = re.search(r'(pip install \S+|npm install \S+|docker pull \S+|yarn add \S+)', readme)
    action = install_match.group(0) if install_match else "Check README for setup"

    brief = [
        f"REPO: {repo_name} [{rank}]",
        f"TASK: {action}",
        f"LINK: {s['url']}"
    ]

    with open("evidence/tech_context.txt", "w") as f:
        f.write("\n".join(brief))
    print(f"✅ Tech Brief secured at tech_context.txt")

if __name__ == "__main__":
    generate_brief()
