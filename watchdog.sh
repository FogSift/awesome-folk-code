#!/bin/bash
# 🐕 FogSift Autonomous Watchdog v2.3
# Logic: Sense -> Guard -> Actuate -> Atomic Research

run_cycle() {
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    echo "🐕 [$TIMESTAMP] Watchdog Cycle Initiated..."

    # 1. Physical/Simulated Loop
    python3 sensors/probe_serial.py || python3 sensors/bridge.py
    python3 sensors/guard.py
    python3 actuate.py

    # 2. Atomic Intelligence Gathering
    python3 trend-sifter.py
    python3 extract-context.py
    python3 curate-intel.py    python3 artifact-harvester.py

    echo "$TIMESTAMP" > evidence/watchdog_heartbeat.txt
    echo "🐕 Cycle Complete."
}

run_cycle
