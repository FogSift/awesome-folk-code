#!/bin/bash
# 🖥️ FogSift Mission Control Dashboard v3.7 (Intel Briefing)

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

clear
echo -e "${CYAN}====================================================${RESET}"
echo -e "${CYAN}             ENVIRONMENTAL INTELLIGENCE             ${RESET}"
echo -e "${CYAN}====================================================${RESET}"

# 1. System Status
if [ -f "evidence/live_moisture.json" ]; then
    MOISTURE=$(cat evidence/live_moisture.json | python3 -c "import sys, json; print(json.load(sys.stdin)['moisture_pct'])")
    echo -e "${GREEN}[ SYSTEM ]${RESET} Soil: ${MOISTURE}% | Status: $(cat evidence/guard_status.json | python3 -c "import json; print(json.load(open('evidence/guard_status.json'))['state'])")"
fi

# 2. Latest Discovery Briefing
echo -e "\n${YELLOW}[ LATEST INTEL BRIEF ]${RESET}"
if [ -f "evidence/tech_context.txt" ]; then
    cat evidence/tech_context.txt | sed 's/^/  • /'
else
    echo "  • No intel gathered yet."
fi

# 3. Biological Assets
echo -e "\n${GREEN}[ BIOLOGICAL ASSETS ]${RESET}"
HARVEST_DATE=$(python3 forecast-harvest.py | grep "Chickpea" | awk '{print $5}')
echo -e "  • Chico Chickpea: 99 Days until Harvest ($HARVEST_DATE)"

echo -e "${CYAN}====================================================${RESET}"
echo -e "COMMANDS: [ status ] [ ./watchdog.sh ] [ ./claim-victory.sh ]"
