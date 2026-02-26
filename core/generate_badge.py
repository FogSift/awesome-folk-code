import json
import os

os.makedirs('assets/art', exist_ok=True)

def create_svg():
    try:
        with open('evidence/live_moisture.json', 'r') as f:
            moisture = json.load(f).get('moisture_pct', 0)
    except Exception:
        moisture = "ERR"

    # Cyberpunk Colors: Red for critical, Cyan for healthy
    color = "#ff0055" if isinstance(moisture, int) and moisture < 40 else "#00ffcc"

    svg_content = f"""<svg xmlns="http://www.w3.org/2000/svg" width="180" height="30" viewBox="0 0 180 30">
  <rect width="180" height="30" rx="4" fill="#1a1a1a"/>
  <rect width="60" height="30" rx="4" fill="#333333"/>
  <text x="30" y="20" fill="#ffffff" font-family="monospace" font-size="14" text-anchor="middle">SOIL</text>
  <text x="120" y="20" fill="{color}" font-family="monospace" font-size="14" font-weight="bold" text-anchor="middle">{moisture}%</text>
</svg>"""

    with open('assets/art/moisture_badge.svg', 'w') as f:
        f.write(svg_content)
    print("🎨 SVG Status Badge Generated: assets/art/moisture_badge.svg")

if __name__ == "__main__":
    create_svg()
