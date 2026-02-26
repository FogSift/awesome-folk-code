#!/bin/bash
# FogSift Tactical Dashboard - Hard-Coded Fix

echo "===================================================="
echo "             ENVIRONMENTAL INTELLIGENCE             "
echo "===================================================="

# 1. System Soil Vitals
# We look exactly where the file is from the root
if [ -f "evidence/moisture_history.txt" ]; then
    SOIL=$(tail -n 1 "evidence/moisture_history.txt" | tr -d '[:space:]')
    echo "[ SYSTEM ] Soil: $SOIL%"
else
    echo "[ SYSTEM ] Soil: [!] evidence/moisture_history.txt not found"
fi
echo "  • Trend: [ ▆▆▆ ]"
echo ""

# 2. Research Stats
echo "[ LATEST RESEARCH ARCHIVE ]"
if [ -f "evidence/research_journal.md" ]; then
    tail -n 5 "evidence/research_journal.md" | sed 's/### //g' | sed 's/---//g'
else
    echo "  • [!] evidence/research_journal.md not found."
fi
echo ""

# 3. Biological Assets
echo "[ BIOLOGICAL ASSETS ]"
if [ -f "scripts/pipeline/forecast-harvest.py" ]; then
    CHICO_DAYS=$(python3 "scripts/pipeline/forecast-harvest.py" 2>/dev/null | grep "DTM" | awk '{print $NF}' | tr -d ')')
    echo "  • Chico Chickpea: $CHICO_DAYS Days until Harvest (2026-06-05)"
else
    echo "  • Chico Chickpea: [!] scripts/pipeline/forecast-harvest.py not found."
fi
echo "===================================================="
echo "COMMANDS: [ status ] [ ./core/watchdog.sh ] [ ./core/claim-victory.sh ]"
