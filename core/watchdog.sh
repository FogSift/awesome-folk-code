#!/bin/bash
# 🐕 FogSift Autonomous Watchdog v2.4
# Sequence: Sense -> Guard -> Actuate -> Extract -> Curate -> Harvest

run_cycle() {
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    echo "🐕 [$TIMESTAMP] Watchdog Cycle Initiated..."

    # 1. Physical/Simulated Environment
    python3 ../scripts/pipeline/sensors/probe_serial.py || python3 ../scripts/pipeline/sensors/bridge.py
    python3 ../scripts/pipeline/sensors/guard.py
    python3 ../scripts/pipeline/sensors/log_history.py
    python3 ../scripts/pipeline/actuate.py

    # 2. Intelligence Pipeline
    python3 ../scripts/pipeline/trend-sifter.py
    python3 ../scripts/pipeline/extract-context.py
    # This is the missing link that populates the journal:
    python3 ../scripts/pipeline/curate-intel.py
    python3 ../scripts/pipeline/artifact-harvester.py

    echo "$TIMESTAMP" > evidence/watchdog_heartbeat.txt
    echo "🐕 Cycle Complete. Archive updated."
}

run_cycle
