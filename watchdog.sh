#!/bin/bash
# 🐕 FogSift Autonomous Watchdog v2.1
# Logic: Sense -> Guard -> Actuate -> Research -> Log

INTERVAL=900 

run_cycle() {
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    echo "🐕 [$TIMESTAMP] Watchdog Cycle Initiated..."

    # 1. SENSE (Physical prioritize, then simulated)
    python3 sensors/probe_serial.py || python3 sensors/bridge.py

    # 2. GUARD (Safety Check)
    python3 sensors/guard.py

    # 3. ACTUATE (Logic + Safety Interlock)
    python3 actuate.py

    # 4. RESEARCH (Intelligence Sifting)
    python3 trend-sifter.py
    python3 artifact-harvester.py

    # 5. HEARTBEAT
    echo "$TIMESTAMP" > evidence/watchdog_heartbeat.txt
    echo "🐕 Cycle Complete. Sleeping."
}

if [[ "$1" == "--daemon" ]]; then
    while true; do
        run_cycle
        sleep $INTERVAL
    done
else
    run_cycle
fi
