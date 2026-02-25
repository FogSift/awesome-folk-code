#!/bin/bash
# 🖥️ FogSift Mission Control v5.1 (Persistent Memory Edition)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

clear
echo -e "${CYAN}====================================================${RESET}"
echo -e "${CYAN}             ENVIRONMENTAL INTELLIGENCE             ${RESET}"
echo -e "${CYAN}====================================================${RESET}"

# 1. System Status
if [ -f "$DIR/evidence/live_moisture.json" ]; then
    MOISTURE=$(cat "$DIR/evidence/live_moisture.json" | python3 -c "import sys, json; print(json.load(sys.stdin)['moisture_pct'])")
    echo -e "${GREEN}[ SYSTEM ]${RESET} Soil: ${MOISTURE}% | Phase: $(python3 "$DIR/actuate.py" | grep "Life Stage" | awk '{print $4}')"
fi

# 2. Persistent Intel Brief (Reading from Journal)
echo -e "\n${YELLOW}[ LATEST RESEARCH ARCHIVE ]${RESET}"
JOURNAL="$DIR/evidence/research_journal.md"
if [ -f "$JOURNAL" ]; then
    # Grab the last entry block from the journal
    tail -n 10 "$JOURNAL" | grep -E "REPO:|TASK:|LINK:" | sed 's/^/  • /'
else
    echo -e "  • [!] No archived research found. Pulse the watchdog."
fi

# 3. Biological Assets
echo -e "\n${GREEN}[ BIOLOGICAL ASSETS ]${RESET}"
HARVEST_DATE=$(python3 forecast-harvest.py | grep "Chickpea" | awk '{print $5}')
echo -e "  • Chico Chickpea: 99 Days until Harvest ($HARVEST_DATE)"

echo -e "${CYAN}====================================================${RESET}"
echo -e "COMMANDS: [ status ] [ ./watchdog.sh ] [ ./claim-victory.sh ]"
