import urllib.request
import json
import sys

# Chico, CA Coordinates
LAT = 39.7285
LON = -121.8375

def check_forecast():
    url = f"https://api.open-meteo.com/v1/forecast?latitude={LAT}&longitude={LON}&hourly=precipitation_probability&forecast_days=1"
    
    try:
        with urllib.request.urlopen(url) as response:
            data = json.loads(response.read().decode())
            # Get probability for the next 3 hours
            probs = data['hourly']['precipitation_probability'][:3]
            max_prob = max(probs)
            
            if max_prob > 50:
                print(f"🌧️ VETO: {max_prob}% chance of rain detected. Holding pump.")
                return False
            print(f"☀️ CLEAR: {max_prob}% rain probability. Logic remains internal.")
            return True
    except Exception as e:
        print(f"⚠️ Weather API Offline ({e}). Defaulting to internal logic.")
        return True

if __name__ == "__main__":
    # Exit code 0 means "Proceed", 1 means "Veto"
    sys.exit(0 if check_forecast() else 1)
