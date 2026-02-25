import json
import os

TECH_FILE = "evidence/tech_context.txt"
BOM_FILE = "evidence/shopping_list.txt"

def estimate_bom():
    if not os.path.exists(TECH_FILE):
        return

    with open(TECH_FILE, "r") as f:
        context = f.read().lower()

    # Hardware signature database
    hardware_signatures = {
        "dht22": "Temperature/Humidity Sensor",
        "ssd1306": "OLED Display (I2C)",
        "relay": "Channel Relay Module",
        "esp8266": "NodeMCU / Wemos D1 Mini",
        "esp32": "ESP32 Development Board"
    }

    found_parts = [v for k, v in hardware_signatures.items() if k in context]
    
    if found_parts:
        with open(BOM_FILE, "w") as f:
            f.write("\n".join(found_parts))
        print(f"📦 BOM Estimated: {len(found_parts)} parts identified.")

if __name__ == "__main__":
    estimate_bom()
