import json
import subprocess
import os

INTEL_FILE = "evidence/trending_artifacts.json"

def validate_top_repo():
    if not os.path.exists(INTEL_FILE):
        return
        
    with open(INTEL_FILE, 'r') as f:
        data = json.load(f)
        repo_url = data['artifacts'][0]['url']
        repo_name = data['artifacts'][0]['fullName'].split('/')[-1]

    print(f"🔬 Validating {repo_name}...")
    
    # Perform a shallow clone into a temporary sandbox
    os.makedirs("sandbox", exist_ok=True)
    subprocess.run(["git", "clone", "--depth", "1", repo_url, f"sandbox/{repo_name}"], capture_output=True)
    
    # Check for quality markers
    has_reqs = os.path.exists(f"sandbox/{repo_name}/requirements.txt")
    has_readme = os.path.exists(f"sandbox/{repo_name}/README.md")
    
    status = "✅ GARAGE READY" if has_reqs else "⚠️ NO REQS FOUND"
    print(f"Result: {status}")
    
    # Cleanup (keep the garage clean)
    subprocess.run(["rm", "-rf", f"sandbox/{repo_name}"])

if __name__ == "__main__":
    validate_top_repo()
