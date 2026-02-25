import json
import os
from datetime import datetime

# Files
GUARD_FILE = "evidence/guard_status.json"
MOISTURE_FILE = "evidence/live_moisture.json"
HARVEST_FILE = "evidence/harvest_forecast.json" # We'll ensure this exists

def get_dynamic_threshold():
    # Default baseline
    days_left = 99
    if os.path.exists(HARVEST_FILE):
        with open(HARVEST_FILE, 'r') as f:
            days_left = json.load(f).get('days_to_harvest', 99)
    
    # 🧬 Biological Logic
    if days_left > 85:
        return 75  # Germination: Keep it wet
    elif days_left > 40:
        return 65  # Vegetative: Let roots hunt
    else:
        return 55  # Ripening: Stress the plant for better yield

def decide():
    threshold = get_dynamic_threshold()
    
    with open(GUARD_FILE, 'r') as f:
        if json.load(f)['state'] == "PANIC": return

    with open(MOISTURE_FILE, 'r') as f:
        moisture = json.load(f)['moisture_pct']

    print(f"🌱 Life Stage Check: {threshold}% Threshold required.")
    
    if moisture < threshold:
        print(f"🌊 MOISTURE LOW ({moisture}%). TRIGGERING PUMP.")
    else:
        print(f"✅ MOISTURE OPTIMAL ({moisture}%). IDLE.")

if __name__ == "__main__":
    decide()
