# 🛠️ The FogSift Armory
> Vetted hardware for Phase 1 & 2 Actuation.

To maintain "Signal Unity," we recommend using these specific components for your artifacts.

## 🧠 Controller Nodes
* **ESP32-S3:** Best for local AI-bridge sensors. Low power, high connectivity.
* **Raspberry Pi 4/5:** Use for "Edge Nodes" running local LLMs.

## 🛰️ Sensor Mesh
* **Capacitive Moisture Sensors:** Avoid resistive sensors (they corrode in soil).
* **BME280:** Standard for pressure, temp, and humidity telemetry.

## ⚙️ Actuators
* **Peristaltic Pumps:** Best for precise, "vibe-coded" irrigation logic.
* **NEMA 17 Steppers:** Standard for seeder/weeder robotics.
