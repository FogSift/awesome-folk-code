#!/bin/bash
# 🖥️ FogSift Mission Mission Control v4.2

# Get the absolute path of the script directory
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
    GUARD=$(cat "$DIR/evidence/guard_status.json" | python3 -c "import json; print(json.load(open('$DIR/evidence/guard_status.json'))['state'])")
    echo -e "${GREEN}[ SYSTEM ]${RESET} Soil: ${MOISTURE}% | Guard: ${GUARD}"
fi

# 2. Intel Brief (Absolute Path)
echo -e "\n${YELLOW}[ TOP RESEARCH ACTION ]${RESET}"
if [ -f "$DIR/evidence/tech_context.txt" ]; then
    sed 's/^/  • /' "$DIR/evidence/tech_context.txt"
else
    echo -e "  • No current intel brief found. Run ./watchdog.sh"
fi

# 3. Biological Assets
echo -e "\n${GREEN}[ BIOLOGICAL ASSETS ]${RESET}"
HARVEST_DATE=$(python3 forecast-harvest.py | grep "Chickpea" | awk '{print $5}')
echo -e "  • Chico Chickpea: 99 Days until Harvest ($HARVEST_DATE)"

echo -e "${CYAN}====================================================${RESET}"
echo -e "COMMANDS: [ status ] [ ./watchdog.sh ]"
