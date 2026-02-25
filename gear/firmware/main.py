# 💧 FogSift ESP32 Soil Node (MicroPython)
import machine
import time

# Pin Setup (34 is a common ADC pin for moisture sensors)
soil_sensor = machine.ADC(machine.Pin(34))
soil_sensor.atten(machine.ADC.ATTN_11DB) # Full range: 3.3v

while True:
    val = soil_sensor.read()
    # Logic: 4095 is dry, ~1500 is wet (adjust for your sensor)
    moisture_pct = 100 - ((val / 4095) * 100)
    
    print(f"📡 Moisture Level: {moisture_pct:.2f}%")
    
    # Simple Local Safety Logic (Phase 2)
    if moisture_pct < 30:
        print("⚠️ LOW WATER DETECTED")
        
    time.sleep(60)
