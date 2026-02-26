import json
import urllib.request
import os
from datetime import datetime

SIM_URL = "http://localhost:8080/ACTUATE_PUMP"
MOISTURE_FILE = "evidence/live_moisture.json"
LOG = "evidence/actuation_history.md"

def trigger_actuator():
    print(f"📡 Signaling Actuator at {SIM_URL}...")
    try:
        req = urllib.request.Request(SIM_URL, method='POST')
        with urllib.request.urlopen(req, timeout=2) as response:
            return response.getcode() == 200
    except Exception as e:
        print(f"❌ Actuator Link Offline: {e}")
        return False

def main():
    if not os.path.exists(MOISTURE_FILE): return
    with open(MOISTURE_FILE, 'r') as f:
        data = json.load(f)

    moisture = data.get('moisture_pct', 100)
    if moisture < 40:
        print(f"🌊 CRITICAL: Moisture at {moisture}%.")
        if trigger_actuator():
            ts = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            with open(LOG, 'a') as f:
                f.write(f"| {ts} | {moisture}% | 🛰️ SIMULATED ACTUATION SUCCESS |\n")
        else:
            print("⚠ Failed to reach Actuator.")

if __name__ == "__main__":
    main()
