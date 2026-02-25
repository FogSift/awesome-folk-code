#!/bin/bash
# 🖥️ FogSift Mission Control Dashboard v3.4 (BOM Aware)

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
RESET='\033[0m'

clear
echo -e "${BLUE}"
echo "  ______ ____   ______ _____ _____ ______ _______ "
echo " |  ____/ __ \ / ____/ ____|_   _|  ____|__   __|"
echo " | |__ | |  | | |  _| (___   | | | |__     | |   "
echo " |  __|| |  | | | |_ \___ \  | | |  __|    | |   "
echo " | |   | |__| | |__| |____) |_| |_| |       | |   "
echo " |_|    \____/ \____|_____/|_____|_|       |_|   "
echo -e "${RESET}"

echo -e "${CYAN}====================================================${RESET}"
echo -e "${CYAN}             ENVIRONMENTAL INTELLIGENCE             ${RESET}"
echo -e "${CYAN}====================================================${RESET}"

# 1. Local Weather
if [ -f "evidence/local_weather.json" ]; then
    TEMP=$(python3 -c "import json; print(json.load(open('evidence/local_weather.json'))['temp'])")
    echo -e "${YELLOW}[ WEATHER ]${RESET} Chico: $TEMP"
fi

# 2. System Status
echo -e "\n${GREEN}[ SYSTEM STATUS ]${RESET}"
if [ -f "evidence/live_moisture.json" ]; then
    MOISTURE=$(cat evidence/live_moisture.json | python3 -c "import sys, json; print(json.load(sys.stdin)['moisture_pct'])")
    printf "  • Soil Moisture: ["
    BAR_SIZE=$(( MOISTURE / 5 ))
    for ((i=0; i<BAR_SIZE; i++)); do printf "#"; done
    for ((i=BAR_SIZE; i<20; i++)); do printf "."; done
    printf "] ${MOISTURE}%%\n"
fi

# 3. Research & BOM Insight
if [ -f "evidence/trending_artifacts.json" ]; then
    TOP_REPO=$(python3 -c "import json; print(json.load(open('evidence/trending_artifacts.json'))['artifacts'][0]['fullName'])")
    echo -e "  • Top Discovery:  ${YELLOW}$TOP_REPO${RESET}"
    
    if [ -f "evidence/tech_context.txt" ]; then
        echo -e "  • Tech Found:     ${BLUE}$(cat evidence/tech_context.txt)${RESET}"
    fi
    
    if [ -f "evidence/shopping_list.txt" ]; then
        echo -e "  • BOM Estimate:   ${GREEN}$(cat evidence/shopping_list.txt | tr '\n' ',' | sed 's/,$//')${RESET}"
    fi
fi

# 4. Biological Assets
echo -e "\n${GREEN}[ BIOLOGICAL ASSETS ]${RESET}"
HARVEST_DATE=$(python3 forecast-harvest.py | grep "Chickpea" | awk '{print $5}')
echo -e "  • ${YELLOW}Chico Chickpea:${RESET} 99 Days until Harvest ($HARVEST_DATE)"

echo -e "${CYAN}====================================================${RESET}"
echo -e "COMMANDS: [ status ] [ ./watchdog.sh ]"
