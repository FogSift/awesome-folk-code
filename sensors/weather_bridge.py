import json
import urllib.request
import os
import ssl

# 🌦️ FogSift Open-Meteo Weather Bridge (Hardened for macOS SSL)
LAT, LON = 39.73, -121.84
URL = f"https://api.open-meteo.com/v1/forecast?latitude={LAT}&longitude={LON}&current=temperature_2m,relative_humidity_2m,weather_code&temperature_unit=fahrenheit&wind_speed_unit=mph&timezone=America%2FLos_Angeles"
DATA_FILE = "evidence/local_weather.json"

def get_weather():
    try:
        # Create unverified context to bypass macOS certificate issues
        context = ssl._create_unverified_context()
        with urllib.request.urlopen(URL, timeout=5, context=context) as response:
            data = json.loads(response.read().decode())
            current = data['current']
            
            # Weather Code Mapping
            codes = {0: "☀️ Clear", 1: "🌤️ Mainly Clear", 2: "⛅ Partly Cloudy", 3: "☁️ Overcast", 45: "🌫️ Fog"}
            weather_desc = codes.get(current['weather_code'], "📡 Signal Active")
            
            weather_data = {
                "temp": f"{current['temperature_2m']}°F",
                "humidity": f"{current['relative_humidity_2m']}%",
                "desc": weather_desc
            }
            
            os.makedirs(os.path.dirname(DATA_FILE), exist_ok=True)
            with open(DATA_FILE, 'w') as f:
                json.dump(weather_data, f)
            return True
    except Exception as e:
        # Log to a temporary file for debugging if needed
        return False

if __name__ == "__main__":
    get_weather()
