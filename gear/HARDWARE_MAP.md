# 🔌 FogSift Phase 3: Hardware Actuation Map

## 🎯 The Goal
Convert a high signal from the ESP32 into 12V power for the water pump.

## 🗺️ Wiring Diagram (Conceptual)
1. **ESP32 Pin 23 (Signal)** → Relay Module **IN**
2. **ESP32 GND** → Relay Module **GND**
3. **ESP32 5V/VIN** → Relay Module **VCC**
4. **Pump (+) Wire** → Relay **COM** (Common)
5. **12V Power Source (+)** → Relay **NO** (Normally Open)
6. **Pump (-) Wire** → **12V Power Source (-)**

## 🧠 The Logic
When `actuate.py` detects moisture below 40%, it will eventually send a command to the ESP32 to set **Pin 23 to HIGH**. The relay will click, completing the 12V circuit, and the pump will engage.

---
*Status: Digital Logic Verified | Physical Wiring Pending*
