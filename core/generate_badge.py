import json
import os

os.makedirs('assets/art', exist_ok=True)

def generate_svg(filename, label, value, color, width=180):
    # Dynamically draw the SVG structure
    svg_content = f"""<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="30" viewBox="0 0 {width} 30">
  <rect width="{width}" height="30" rx="4" fill="#1a1a1a"/>
  <rect width="60" height="30" rx="4" fill="#333333"/>
  <text x="30" y="20" fill="#ffffff" font-family="monospace" font-size="14" text-anchor="middle">{label}</text>
  <text x="{60 + (width-60)/2}" y="20" fill="{color}" font-family="monospace" font-size="14" font-weight="bold" text-anchor="middle">{value}</text>
</svg>"""
    with open(f'assets/art/{filename}', 'w') as f:
        f.write(svg_content)

def main():
    # 1. Read Current Intelligence
    try:
        with open('evidence/live_moisture.json', 'r') as f:
            moisture = json.load(f).get('moisture_pct', 0)
    except: moisture = "ERR"

    try:
        with open('evidence/local_weather.json', 'r') as f:
            temp = json.load(f).get('temp_f', 0)
    except: temp = "ERR"

    # 2. Determine States & Colors
    m_color = "#ff0055" if isinstance(moisture, int) and moisture < 40 else "#00ffcc" # Red / Cyan
    
    if isinstance(temp, float) or isinstance(temp, int):
        t_color = "#ff7700" if temp > 90 else "#00ffcc" # Orange / Cyan
        temp_str = f"{temp}°F"
    else:
        t_color = "#777777"
        temp_str = str(temp)

    risk = "LOW"
    r_color = "#00ffcc" # Cyan
    if isinstance(moisture, int) and (isinstance(temp, float) or isinstance(temp, int)):
        if temp > 100 and moisture < 50:
            risk = "CRITICAL"
            r_color = "#ff0055" # Red
        elif temp > 85 and moisture < 55:
            risk = "ELEVATED"
            r_color = "#ffcc00" # Yellow

    # 3. Paint the Badges
    generate_svg("moisture_badge.svg", "SOIL", f"{moisture}%", m_color)
    generate_svg("temp_badge.svg", "TEMP", temp_str, t_color)
    generate_svg("risk_badge.svg", "RISK", risk, r_color, width=200) # Slightly wider for 'CRITICAL'

    print("🎨 SVG HUD Generated: Soil, Temp, and Risk badges updated.")

if __name__ == "__main__":
    main()
