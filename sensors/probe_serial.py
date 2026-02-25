import serial
import serial.tools.list_ports
import json
import os

DATA_FILE = "evidence/live_moisture.json"
CAL_FILE = "evidence/soil_calibration.json"

def get_calibrated_pct(raw_val):
    if not os.path.exists(CAL_FILE):
        return 50 # Default fallback
    
    with open(CAL_FILE, 'r') as f:
        cal = json.load(f)
    
    # Linear mapping: (raw - max) / (min - max) * 100
    pct = (raw_val - cal['adc_max']) / (cal['adc_min'] - cal['adc_max']) * 100
    return max(0, min(100, int(pct)))

def read_physical_sensor():
    ports = list(serial.tools.list_ports.comports())
    usb_port = next((p.device for p in ports if "usb" in p.device.lower()), None)
    
    if not usb_port:
        return False

    try:
        with serial.Serial(usb_port, 115200, timeout=2) as ser:
            line = ser.readline().decode('utf-8').strip()
            if line.isdigit():
                raw_adc = int(line)
                moisture = get_calibrated_pct(raw_adc)
                
                data = {
                    "sensor_id": "PHYSICAL_NODE_01",
                    "moisture_pct": moisture,
                    "raw_adc": raw_adc,
                    "status": "CALIBRATED"
                }
                with open(DATA_FILE, 'w') as f:
                    json.dump(data, f)
                return True
    except Exception:
        return False

if __name__ == "__main__":
    read_physical_sensor()
