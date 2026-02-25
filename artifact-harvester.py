import json
import os
import subprocess

INTEL_FILE = "evidence/trending_artifacts.json"
INDEX_FILE = "gear/HARDWARE_INDEX.md"

def harvest():
    if not os.path.exists(INTEL_FILE):
        return

    with open(INTEL_FILE, 'r') as f:
        data = json.load(f)
        repos = data.get('artifacts', data.get('repos', []))

    if not repos:
        print("📭 No artifacts to harvest.")
        return

    print(f"🌾 Harvesting {len(repos)} discovered artifacts...")
    
    with open(INDEX_FILE, 'w') as f:
        f.write("# 📚 FogSift Hardware Index\n")
        f.write(f"Last updated: {os.popen('date').read()}\n")
        for repo in repos:
            f.write(f"## {repo['fullName']}\n")
            f.write(f"- **URL:** {repo['url']}\n")
            f.write(f"- **Description:** {repo['description']}\n\n")

    print(f"✅ gear/HARDWARE_INDEX.md updated.")

if __name__ == "__main__":
    harvest()
