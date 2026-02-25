import json
import os
from datetime import datetime

# 💧 FogSift Actuation Bridge v1.0
MOISTURE_FILE = "evidence/live_moisture.json"
ACTUATION_LOG = "evidence/actuation_history.md"
THRESHOLD = 40  # Trigger pump if moisture drops below 40%

def check_and_actuate():
    if not os.path.exists(MOISTURE_FILE):
        print("⚠️ No moisture data detected. Actuation suspended.")
        return

    with open(MOISTURE_FILE, 'r') as f:
        data = json.load(f)
    
    moisture = data['moisture_pct']
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    print(f"🔍 Analyzing Moisture: {moisture}% (Threshold: {THRESHOLD}%)")

    if moisture < THRESHOLD:
        trigger_pump(moisture, timestamp)
    else:
        print("✅ Moisture optimal. Pump remains IDLE.")

def trigger_pump(val, time):
    log_entry = f"| {time} | {val}% | 🌊 PUMP TRIGGERED |"
    print(f"🌊 ALERT: {log_entry}")
    
    # Write to local history
    if not os.path.exists(ACTUATION_LOG):
        with open(ACTUATION_LOG, 'w') as f:
            f.write("# 🌊 FogSift Actuation History\n| Timestamp | Moisture | Action |\n| :--- | :--- | :--- |\n")
    
    with open(ACTUATION_LOG, 'a') as f:
        f.write(log_entry + "\n")

if __name__ == "__main__":
    check_and_actuate()
