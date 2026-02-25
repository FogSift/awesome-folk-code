import machine
import time

# 🛠️ FogSift MicroPython Sensor Node v1.0
# Hardware: Capacitive Soil Moisture Sensor on Pin 34 (Analog)
sensor_pin = machine.ADC(machine.Pin(34))
sensor_pin.atten(machine.ADC.ATTN_11DB) # Full range: 3.3v

def read_moisture():
    val = sensor_pin.read()
    # Map raw analog (0-4095) to percentage (0-100)
    # Note: Calibration values (min/max) will vary by sensor
    pct = 100 - int((val / 4095) * 100)
    return pct

print("📡 FogSift Sensor Node Active...")

while True:
    moisture = read_moisture()
    print(moisture) # This is what sensors/probe_serial.py reads
    time.sleep(15)  # Align with Watchdog cycle
