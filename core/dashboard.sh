#!/bin/bash
# 🌫️ FogSift Sovereign Dashboard v5.2 (Fixed & Handover Ready)

# Update the "World"
python3 core/climate_sim.py > /dev/null
RISK_OUT=$(python3 scripts/pipeline/analyze_risk.py 2>&1)

# Extract LIVE Moisture (Targets the value specifically to avoid Sensor ID collisions)
LIVE_MOISTURE=$(grep -oE '"moisture_pct": [0-9]+' evidence/live_moisture.json | grep -oE '[0-9]+')

echo "===================================================="
echo "             ENVIRONMENTAL INTELLIGENCE"
echo "===================================================="
echo "[ SYSTEM ] Soil: $LIVE_MOISTURE%"
echo "$RISK_OUT"
echo "----------------------------------------------------"

# Call the visualizer
if [ -f "core/visualizer.py" ]; then
    python3 core/visualizer_v2.py
fi

echo ""
echo "[ BIOLOGICAL ASSETS ]"
echo "  • Chico Chickpea: 100 Days until Harvest (2026-06-05)"
echo "===================================================="
echo "COMMANDS: [ status ] [ ./core/run_actuation.sh ] [ ./core/claim-victory.sh ]"
