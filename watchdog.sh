#!/bin/bash
# 🐕 FogSift Autonomous Watchdog v2.4
# Sequence: Sense -> Guard -> Actuate -> Extract -> Curate -> Harvest

run_cycle() {
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    echo "🐕 [$TIMESTAMP] Watchdog Cycle Initiated..."

    # 1. Physical/Simulated Environment
    python3 sensors/probe_serial.py || python3 sensors/bridge.py
    python3 sensors/guard.py
    python3 sensors/log_history.py
    python3 actuate.py

    # 2. Intelligence Pipeline
    python3 trend-sifter.py
    python3 extract-context.py
    # This is the missing link that populates the journal:
    python3 curate-intel.py
    python3 artifact-harvester.py

    echo "$TIMESTAMP" > evidence/watchdog_heartbeat.txt
    echo "🐕 Cycle Complete. Archive updated."
}

run_cycle
