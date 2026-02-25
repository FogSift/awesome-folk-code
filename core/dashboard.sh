#!/bin/bash
# FogSift Tactical Dashboard - Fixed Wiring

# Internal data paths
RESEARCH_JOURNAL="evidence/research_journal.md"
MOISTURE_FILE="evidence/moisture_history.txt"

echo "===================================================="
echo "             ENVIRONMENTAL INTELLIGENCE             "
echo "===================================================="

# 1. System Soil Vitals
SOIL=$(python3 -c "import os; print(open('$MOISTURE_FILE').readlines()[-1].strip())" 2>/dev/null || echo "??")
echo "[ SYSTEM ] Soil: $SOIL%"
echo "  • Trend: [ ▆▆▆ ]"
echo ""

# 2. Research Stats
echo "[ LATEST RESEARCH ARCHIVE ]"
if [ -f "$RESEARCH_JOURNAL" ]; then
    tail -n 5 "$RESEARCH_JOURNAL" | sed 's/### //g' | sed 's/---//g'
else
    echo "  • [!] No Research Found."
fi
echo ""

# 3. Biological Assets
echo "[ BIOLOGICAL ASSETS ]"
CHICO_DAYS=$(python3 scripts/pipeline/forecast-harvest.py 2>/dev/null || echo "??")
echo "  • Chico Chickpea: $CHICO_DAYS Days until Harvest (2026-06-05)"
echo "===================================================="
echo "COMMANDS: [ status ] [ ./watchdog.sh ] [ ./claim-victory.sh ]"
