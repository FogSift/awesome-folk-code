import json
import sys

def calculate_risk():
    with open('evidence/live_moisture.json', 'r') as f:
        moisture = json.load(f)['moisture_pct']
    with open('evidence/local_weather.json', 'r') as f:
        weather = json.load(f)

    risk_level = "LOW"
    exit_code = 0 # Standard

    # HEATWAVE PROACTIVE TRIGGER:
    # If it's over 100°F and moisture is below 50%, it's an emergency.
    if weather['temp_f'] > 100 and moisture < 50:
        risk_level = "CRITICAL (HEATWAVE)"
        exit_code = 2 # Signal for Proactive Actuation
    elif weather['temp_f'] > 85 and moisture < 55:
        risk_level = "ELEVATED"
    
    print(f"⚖️ Risk Analysis: {risk_level} (Moisture: {moisture}%, Temp: {weather['temp_f']}°F)")
    sys.exit(exit_code)

if __name__ == "__main__":
    calculate_risk()
