import json
import random
import os

# 💧 FogSift Sensor Bridge (Simulation)
DATA_FILE = "evidence/live_moisture.json"

def simulate_sensor():
    moisture = random.randint(35, 75)
    data = {
        "sensor_id": "SOIL_SYNC_BETA_01",
        "moisture_pct": moisture,
        "status": "ONLINE" if moisture > 40 else "LOW_WATER"
    }
    
    os.makedirs(os.path.dirname(DATA_FILE), exist_ok=True)
    with open(DATA_FILE, 'w') as f:
        json.dump(data, f)
    
    print(f"📡 Signal Emitted: {moisture}% Moisture")

if __name__ == "__main__":
    simulate_sensor()
