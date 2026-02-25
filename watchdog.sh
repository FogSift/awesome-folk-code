#!/bin/bash
# 🐕 FogSift Autonomous Watchdog v2.0
# Logic: Sense -> Actuate -> Log -> Wait

INTERVAL=900 # 15 minutes

run_cycle() {
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    echo "🐕 [$TIMESTAMP] Watchdog Cycle Initiated..."
    
    # 1. Update Environment (Weather)
    python3 sensors/weather_bridge.py
    
    # 2. Update Soil Data (Sense)
    python3 sensors/bridge.py
    
    # 3. Decision Logic (Actuate)
    python3 actuate.py
    
    # 4. Record Heartbeat
    echo "$TIMESTAMP" > evidence/watchdog_heartbeat.txt
    echo "🐕 Cycle Complete. Sleeping for $INTERVAL seconds."
}

# Check if flag --daemon is passed
if [[ "$1" == "--daemon" ]]; then
    echo "🛰️ Watchdog entering Orbit (Background Mode)..."
    while true; do
        run_cycle
        sleep $INTERVAL
    done
else
    run_cycle
fi
