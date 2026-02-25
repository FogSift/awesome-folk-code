import json
import subprocess
import os

INTEL_FILE = "evidence/trending_artifacts.json"

def validate_top_repo():
    if not os.path.exists(INTEL_FILE):
        return
        
    with open(INTEL_FILE, 'r') as f:
        data = json.load(f)
        # Handle cases where the key might be 'artifacts' or 'repos' based on your versions
        key = 'artifacts' if 'artifacts' in data else 'repos'
        repo_url = data[key][0]['url']
        repo_name = data[key][0]['fullName'].split('/')[-1]

    print(f"🔬 Validating {repo_name} for Garage readiness...")
    
    os.makedirs("sandbox", exist_ok=True)
    subprocess.run(["git", "clone", "--depth", "1", repo_url, f"sandbox/{repo_name}"], capture_output=True)
    
    # 🔍 Quality Markers
    markers = {
        "Python Reqs": os.path.exists(f"sandbox/{repo_name}/requirements.txt"),
        "MicroPython Core": os.path.exists(f"sandbox/{repo_name}/main.py") or os.path.exists(f"sandbox/{repo_name}/boot.py"),
        "Documentation": os.path.exists(f"sandbox/{repo_name}/README.md")
    }
    
    # Logic: It's "Garage Ready" if it has Python deps OR MicroPython entry points
    is_ready = markers["Python Reqs"] or markers["MicroPython Core"]
    
    status = "✅ GARAGE READY" if is_ready else "⚠️ INCOMPLETE STRUCTURE"
    
    # Log the result locally for the dashboard
    with open("evidence/last_validation.txt", "w") as f:
        f.write(f"{repo_name}: {status}")
        
    print(f"Result: {status}")
    subprocess.run(["rm", "-rf", f"sandbox/{repo_name}"])

if __name__ == "__main__":
    validate_top_repo()
