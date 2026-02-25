# 🏺 Artifact: Soil-Sync-Beta
> A local Python script that pings ESP32 moisture sensors and alerts via Claude.

## 🛠️ The Tech Stack
* **Logic:** Claude 3.5 Sonnet (Decision Engine)
* **Actuation:** Python 3.12 (Local Bridge)
* **Hardware:** ESP32 + Capacitive Moisture Sensors

## 🌫️ FogSift Mapping
* **Upstream:** Local Sensor Mesh
* **Downstream:** iOS Notification via Pushcut

## 🧭 Setup
1. Flash ESP32 with `sensor_node.ino`.
2. Run `sync_bridge.py` on your local Mac.
3. Configure Claude API key in `.env` (Ignored by Git).

---
*Phase 1: Active Backyard Pilot.*
