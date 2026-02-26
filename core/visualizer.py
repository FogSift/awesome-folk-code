import re

def get_spark(value):
    ticks = [' ', '▂', '▃', '▄', '▅', '▆', '▇', '█']
    idx = min(int(float(value) / 12.5), 7)
    return ticks[idx]

try:
    with open('evidence/actuation_history.md', 'r') as f:
        content = f.read()
        points = [int(p) for p in re.findall(r'(\d+)%', content)]
        
        if len(points) >= 2:
            sparkline = "".join([get_spark(p) for p in points[-20:]])
            # Basic prediction: if drying out (last point < second to last)
            diff = points[-1] - points[-2]
            status_msg = f"📈 Trend: {sparkline} ({points[-1]}%)"
            
            if diff < 0:
                hours_left = (points[-1] - 40) / abs(diff) if diff != 0 else 0
                status_msg += f" | ⏳ Est. {max(0, round(hours_left, 1))}h to Critical"
            else:
                status_msg += " | 💧 Recovery Active"
                
            print(status_msg)
        else:
            print("📈 Moisture Trend: [ INITIALIZING ]")
except Exception:
    print("📈 Moisture Trend: [ OFFLINE ]")
