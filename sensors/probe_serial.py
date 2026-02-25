import serial
import serial.tools.list_ports
import json
import os

# 📡 FogSift Physical Serial Bridge
DATA_FILE = "evidence/live_moisture.json"

def find_sensor():
    ports = list(serial.tools.list_ports.comports())
    for p in ports:
        if "usb" in p.device.lower():
            return p.device
    return None

def read_physical_sensor():
    port = find_sensor()
    if not port:
        print("⚠️ No physical sensor detected on USB. Falling back to simulation.")
        return False

    try:
        with serial.Serial(port, 115200, timeout=2) as ser:
            line = ser.readline().decode('utf-8').strip()
            # Expecting simple integer moisture value from ESP32
            moisture = int(line)
            data = {
                "sensor_id": "PHYSICAL_NODE_01",
                "moisture_pct": moisture,
                "status": "ONLINE"
            }
            with open(DATA_FILE, 'w') as f:
                json.dump(data, f)
            print(f"🔌 Physical Signal Captured: {moisture}%")
            return True
    except Exception as e:
        print(f"❌ Serial Error: {e}")
        return False

if __name__ == "__main__":
    read_physical_sensor()
