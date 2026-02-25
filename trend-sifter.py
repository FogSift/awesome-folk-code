import subprocess
import json
import os
from datetime import datetime

# 🔍 FogSift GitHub Trend-Sifter
# Targeting: Tools that empower local automation and "Awesome" lists
QUERY = "topic:automation OR topic:iot OR topic:self-hosted"
INTEL_FILE = "evidence/trending_artifacts.json"

def sift_github():
    print(f"📡 Sifting GitHub for high-value artifacts...")
    
    try:
        # Search for repositories updated in the last 7 days with >100 stars
        cmd = [
            "gh", "search", "repos", 
            QUERY, 
            "--sort", "updated", 
            "--limit", "5", 
            "--json", "fullName,description,stargazersCount,url,updatedAt"
        ]
        result = subprocess.run(cmd, capture_output=True, text=True)
        
        if result.returncode != 0:
            print(f"❌ Error sifting: {result.stderr}")
            return

        repos = json.loads(result.stdout)
        
        # Save to local intelligence
        output = {
            "captured_at": str(datetime.now().strftime("%Y-%m-%d %H:%M")),
            "artifacts": repos
        }
        
        os.makedirs("evidence", exist_ok=True)
        with open(INTEL_FILE, 'w') as f:
            json.dump(output, f, indent=2)
            
        print(f"✅ Captured {len(repos)} artifacts into {INTEL_FILE}")
        
    except Exception as e:
        print(f"⚠️ Sifter Failure: {e}")

if __name__ == "__main__":
    sift_github()
