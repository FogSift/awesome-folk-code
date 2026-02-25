import json
import os

MOISTURE_FILE = "evidence/live_moisture.json"
HISTORY_FILE = "evidence/moisture_history.txt"

def log_moisture():
    if not os.path.exists(MOISTURE_FILE): return
    with open(MOISTURE_FILE, 'r') as f:
        val = json.load(f)['moisture_pct']
    
    with open(HISTORY_FILE, 'a') as f:
        f.write(f"{val}\n")
    
    # Keep only last 5 readings
    with open(HISTORY_FILE, 'r') as f:
        lines = f.readlines()
    with open(HISTORY_FILE, 'w') as f:
        f.writelines(lines[-5:])

if __name__ == "__main__":
    log_moisture()
