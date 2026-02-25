import json
import os

GUARD_FILE = "evidence/guard_status.json"
MOISTURE_FILE = "evidence/live_moisture.json"
THRESHOLD = 70  # Chickpea Baseline

def decide():
    if not os.path.exists(GUARD_FILE):
        print("⚠️ No Guard signal. Defaulting to SAFE/OFF.")
        return

    with open(GUARD_FILE, 'r') as f:
        guard = json.load(f)

    if guard['state'] == "PANIC":
        print(f"🚨 ACTUATION LOCKED: {guard['reason']}")
        return

    with open(MOISTURE_FILE, 'r') as f:
        moisture = json.load(f)['moisture_pct']

    if moisture < THRESHOLD:
        print(f"🌊 MOISTURE LOW ({moisture}%). TRIGGERING PUMP.")
        # Physical command to ESP32 would go here
    else:
        print(f"✅ MOISTURE OPTIMAL ({moisture}%). IDLE.")

if __name__ == "__main__":
    decide()
