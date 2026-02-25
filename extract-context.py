import subprocess
import json
import os

INTEL_FILE = "evidence/trending_artifacts.json"

def get_readme_summary():
    if not os.path.exists(INTEL_FILE):
        return
        
    with open(INTEL_FILE, 'r') as f:
        data = json.load(f)
        repo = data['artifacts'][0]['fullName']

    print(f"📖 Extracting context for {repo}...")
    
    # Use gh to view the readme
    cmd = ["gh", "repo", "view", repo, "--json", "readme"]
    result = subprocess.run(cmd, capture_output=True, text=True)
    
    if result.returncode == 0:
        readme_content = json.loads(result.stdout)['readme']
        # Search for key technical terms
        tech_keywords = ["install", "pip", "setup", "esp32", "pins"]
        found = [kw for kw in tech_keywords if kw in readme_content.lower()]
        
        summary = f"Found Tech: {', '.join(found) if found else 'Conceptual Only'}"
        with open("evidence/tech_context.txt", "w") as f:
            f.write(summary)
        print(f"✅ Context saved: {summary}")

if __name__ == "__main__":
    get_readme_summary()
