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
    python3 sensors/probe_serial.py    python3 sensors/bridge.py
    python3 sensors/guard.py    
    # 3. Decision Logic (Actuate)
    python3 actuate.py
    python3 trend-sifter.py 
    python3 curate-intel.py    
    python3 validate-discovery.py    # 4. Record Heartbeat
    python3 extract-context.py    echo "$TIMESTAMP" > evidence/watchdog_heartbeat.txt
    python3 extract-bom.py    echo "🐕 Cycle Complete. Sleeping for $INTERVAL seconds."
    python3 artifact-harvester.py}

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
