import json
import os

os.makedirs('assets/art', exist_ok=True)

def generate_svg(filename, label, value, color, width=180, is_critical=False):
    # Determine animation speed based on critical state
    anim_dur = "0.5s" if is_critical else "3s"
    
    # Inject CSS Animation directly into the SVG
    svg_content = f"""<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="30" viewBox="0 0 {width} 30">
  <style>
    @keyframes pulse {{
      0% {{ opacity: 1; }}
      50% {{ opacity: 0.6; }}
      100% {{ opacity: 1; }}
    }}
    .animate-text {{
      animation: pulse {anim_dur} infinite ease-in-out;
    }}
  </style>
  <rect width="{width}" height="30" rx="4" fill="#1a1a1a"/>
  <rect width="60" height="30" rx="4" fill="#333333"/>
  <text x="30" y="20" fill="#ffffff" font-family="monospace" font-size="14" text-anchor="middle">{label}</text>
  <text class="animate-text" x="{60 + (width-60)/2}" y="20" fill="{color}" font-family="monospace" font-size="14" font-weight="bold" text-anchor="middle">{value}</text>
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
    is_dry = isinstance(moisture, int) and moisture < 40
    m_color = "#ff0055" if is_dry else "#00ffcc"
    
    if isinstance(temp, float) or isinstance(temp, int):
        t_color = "#ff7700" if temp > 90 else "#00ffcc"
        temp_str = f"{temp}°F"
    else:
        t_color = "#777777"
        temp_str = str(temp)

    risk = "LOW"
    r_color = "#00ffcc"
    is_risk_crit = False
    
    if isinstance(moisture, int) and (isinstance(temp, float) or isinstance(temp, int)):
        if temp > 100 and moisture < 50:
            risk = "CRITICAL"
            r_color = "#ff0055"
            is_risk_crit = True
        elif temp > 85 and moisture < 55:
            risk = "ELEVATED"
            r_color = "#ffcc00"

    # 3. Paint the Animated Badges
    generate_svg("moisture_badge.svg", "SOIL", f"{moisture}%", m_color, is_critical=is_dry)
    generate_svg("temp_badge.svg", "TEMP", temp_str, t_color, is_critical=(temp>90))
    generate_svg("risk_badge.svg", "RISK", risk, r_color, width=200, is_critical=is_risk_crit)

    print("🎨 SVG HUD Generated: Animated badges deployed.")

if __name__ == "__main__":
    main()
