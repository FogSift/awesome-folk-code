#!/bin/bash
# 🏆 FogSift Manual Actuation Override
echo "🏆 ARCHITECT OVERRIDE: Forcing Actuation..."

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
MOISTURE_VAL=$(cat evidence/live_moisture.json | python3 -c "import sys, json; print(json.load(sys.stdin)['moisture_pct'])")

# Log the manual override
echo "| $TIMESTAMP | $MOISTURE_VAL% | 🏆 MANUAL OVERRIDE (Victory) |" >> evidence/actuation_history.md

echo "--------------------------------------"
echo "✅ Override logged. Pump Relay (Conceptual) Pulsed."
echo "📊 Current Status:"
./dashboard.sh | grep -A 2 "SYSTEM STATUS"
