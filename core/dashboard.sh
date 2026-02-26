#!/bin/bash
# 🌫️ FogSift Sovereign Dashboard v5.1 (Live-Sync)

# 1. Update the "World"
python3 core/climate_sim.py > /dev/null
RISK_OUT=$(python3 scripts/pipeline/analyze_risk.py 2>&1)

# 2. Extract LIVE Data (Not Stale)
LIVE_MOISTURE=$(grep -oE '[0-9]+' evidence/live_moisture.json | head -1)

echo "===================================================="
echo "             ENVIRONMENTAL INTELLIGENCE"
echo "===================================================="
echo "[ SYSTEM ] Soil: $LIVE_MOISTURE%"
echo "$RISK_OUT"
echo "----------------------------------------------------"

# 3. Call the visualizer
if [ -f "core/visualizer.py" ]; then
    python3 core/visualizer.py
fi

echo ""
echo "[ BIOLOGICAL ASSETS ]"
echo "  • Chico Chickpea: 100 Days until Harvest (2026-06-05)"
echo "===================================================="
echo "COMMANDS: [ status ] [ ./core/run_actuation.sh ] [ ./core/claim-victory.sh ]"
