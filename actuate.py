import json
import os
from datetime import datetime

GUARD_FILE = "evidence/guard_status.json"
MOISTURE_FILE = "evidence/live_moisture.json"
WEATHER_FILE = "evidence/local_weather.json"
THRESHOLD = 70

def decide():
    # 1. Check Safety Guard
    with open(GUARD_FILE, 'r') as f:
        if json.load(f)['state'] == "PANIC": return

    # 2. Time-of-Day Check (Night Overrule)
    # Evaporation is high between 10 AM and 6 PM
    current_hour = datetime.now().hour
    is_peak_sun = 10 <= current_hour <= 18

    # 3. Weather Overrule
    if os.path.exists(WEATHER_FILE):
        with open(WEATHER_FILE, 'r') as f:
            weather = json.load(f)['desc'].lower()
            if "rain" in weather or "drizzle" in weather:
                print("🌧️ WEATHER OVERRULE: Rain detected. Pump inhibited.")
                return

    # 4. Final Decision Logic
    with open(MOISTURE_FILE, 'r') as f:
        moisture = json.load(f)['moisture_pct']

    if moisture < THRESHOLD:
        if is_peak_sun:
            print(f"☀️ SUN OVERRULE: Moisture is {moisture}%, but peak sun detected. Waiting for evening.")
        else:
            print(f"🌊 MOISTURE LOW ({moisture}%). TRIGGERING PUMP.")
    else:
        print(f"✅ MOISTURE OPTIMAL ({moisture}%). IDLE.")

if __name__ == "__main__":
    decide()
