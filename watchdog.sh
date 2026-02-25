#!/bin/bash
# 🐕 FogSift Watchdog: Sensor -> Logic -> Actuator
echo "🐕 Watchdog barking..."
python3 sensors/bridge.py
python3 actuate.py

# Record the heartbeat
date "+%Y-%m-%d %H:%M:%S" > evidence/watchdog_heartbeat.txt

echo "🐕 Watchdog sleeping. Heartbeat recorded."
