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
        # Handle the list whether it's under 'artifacts' or 'repos'
        repo_data = data.get('artifacts', data.get('repos', []))[0]
        repo_name = repo_data['fullName']

    print(f"📖 Sifting Vitals for {repo_name}...")
    
    # Pull statistical data + README snippet
    cmd = ["gh", "repo", "view", repo_name, "--json", "stargazersCount,forkCount,openIssuesCount,description,url,readme"]
    result = subprocess.run(cmd, capture_output=True, text=True)
    
    if result.returncode == 0:
        stats = json.loads(result.stdout)
        
        # Format the terminal readout
        brief = [
            f"NAME: {repo_name}",
            f"STATS: ⭐ {stats['stargazersCount']} | 🍴 {stats['forkCount']} | 🛠️ {stats['openIssuesCount']} Issues",
            f"DESC: {stats['description'][:100]}...",
            f"LINK: {stats['url']}"
        ]
        
        with open(BRIEF_FILE, "w") as f:
            f.write("\n".join(brief))
        print(f"✅ Research Brief Secured.")

if __name__ == "__main__":
    generate_brief()
