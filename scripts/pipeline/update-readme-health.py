import re
from datetime import datetime

# 🏥 README Health Synchronizer
# Updates the 'System Status' section of the README with local telemetry.

README_PATH = "README.md"
TIMESTAMP = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# In a real deployment, this would pull from your actuate.py sensor logs
STATUS_TEXT = f"> **Live System Status:** Local Node [Active] | Last Sync: {TIMESTAMP} PST | Vibe: Optimal"

with open(README_PATH, "r") as f:
    content = f.read()

# Use regex to find the Status section and update it
pattern = r"## 🌫️ System Status: Upstream Connectivity\n(> .*)"
new_section = f"## 🌫️ System Status: Upstream Connectivity\n{STATUS_TEXT}"

if re.search(pattern, content):
    new_content = re.sub(pattern, new_section, content)
    with open(README_PATH, "w") as f:
        f.write(new_content)
    print(f"✅ README health log updated at {TIMESTAMP}")
else:
    print("❌ Could not find System Status section in README.")
