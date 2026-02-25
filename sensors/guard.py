import json
import os

DATA_FILE = "evidence/live_moisture.json"
GUARD_FILE = "evidence/guard_status.json"

def safety_check():
    if not os.path.exists(DATA_FILE):
        return False

    with open(DATA_FILE, 'r') as f:
        data = json.load(f)

    raw = data.get('raw_adc', 2000)
    
    # 🚨 Panic Logic: If the sensor is reporting outside realistic bounds
    # (e.g., disconnected or shorted)
    if raw < 500 or raw > 4000:
        status = {"state": "PANIC", "reason": f"Sensor out of bounds: {raw}"}
        print(f"🚨 SAFETY PANIC: {status['reason']}")
    else:
        status = {"state": "CLEAR", "reason": "Signal within normal operating range."}

    with open(GUARD_FILE, 'w') as f:
        json.dump(status, f)

if __name__ == "__main__":
    safety_check()
