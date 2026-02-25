import json
import os

GUARD_FILE = "evidence/guard_status.json"
MOISTURE_FILE = "evidence/live_moisture.json"
WEATHER_FILE = "evidence/local_weather.json"
THRESHOLD = 70

def decide():
    # 1. Check Safety Guard
    with open(GUARD_FILE, 'r') as f:
        if json.load(f)['state'] == "PANIC": return

    # 2. Check Weather Overrule
    if os.path.exists(WEATHER_FILE):
        with open(WEATHER_FILE, 'r') as f:
            weather = json.load(f)['desc'].lower()
            if "rain" in weather or "drizzle" in weather:
                print(f"🌧️ WEATHER OVERRULE: Rain detected in Chico. Pump inhibited.")
                return

    # 3. Standard Moisture Logic
    with open(MOISTURE_FILE, 'r') as f:
        moisture = json.load(f)['moisture_pct']

    if moisture < THRESHOLD:
        print(f"🌊 MOISTURE LOW ({moisture}%). TRIGGERING PUMP.")
    else:
        print(f"✅ MOISTURE OPTIMAL ({moisture}%). IDLE.")

if __name__ == "__main__":
    decide()
