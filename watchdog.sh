#!/bin/bash
# 🐕 FogSift Autonomous Watchdog v2.2
# Logic: Sense -> Guard -> Actuate -> Research & Score -> Log

run_cycle() {
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    echo "🐕 [$TIMESTAMP] Watchdog Cycle Initiated..."

    # 1. Environment & Safety
    python3 sensors/probe_serial.py || python3 sensors/bridge.py
    python3 sensors/guard.py
    python3 actuate.py

    # 2. Intelligence Gathering
    python3 trend-sifter.py
    python3 extract-context.py
    
    # Small buffer to ensure file writes are complete
    sleep 1

    # 3. Artifact Curation
    python3 artifact-harvester.py

    echo "$TIMESTAMP" > evidence/watchdog_heartbeat.txt
    echo "🐕 Cycle Complete. Intelligence Secured."
}

run_cycle
