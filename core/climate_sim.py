import json
from datetime import datetime
data = {
    "timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
    "temp_f": 105.2,
    "humidity_pct": 10.5,
    "uv_index": 11
}
with open('evidence/local_weather.json', 'w') as f:
    json.dump(data, f, indent=4)
