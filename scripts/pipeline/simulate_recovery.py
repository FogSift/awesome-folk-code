import json
import time
import os
from datetime import datetime

MOISTURE_FILE = "evidence/live_moisture.json"
HISTORY_FILE = "evidence/actuation_history.md"

def update_moisture(val):
    data = {"sensor_id": "SIM_01", "moisture_pct": val}
    with open(MOISTURE_FILE, 'w') as f:
        json.dump(data, f)
    
    ts = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(HISTORY_FILE, 'a') as f:
        f.write(f"| {ts} | {val}% | 🌊 SIM_RECOVERY_PULSE |\n")

print("🌊 [ SIMULATION ] Beginning moisture recovery...")
# Simulate a 5-step absorption curve
for pct in [35, 48, 62, 75, 82]:
    update_moisture(pct)
    print(f"💧 Moisture risen to {pct}%...")
    time.sleep(1.5) # Time-lapse simulation

print("✅ [ SIMULATION ] Recovery complete. Chico is hydrated.")
