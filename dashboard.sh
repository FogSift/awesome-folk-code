#!/bin/bash
# 🖥️ FogSift Mission Control Dashboard v2.8 (Safety Integrated)

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
    DESC=$(python3 -c "import json; print(json.load(open('evidence/local_weather.json'))['desc'])")
    echo -e "${YELLOW}[ WEATHER ]${RESET} $DESC | $TEMP"
fi

# 2. System Status & Heartbeat Check
echo -e "\n${GREEN}[ SYSTEM STATUS ]${RESET}"
if [ -f "evidence/live_moisture.json" ]; then
    MOISTURE=$(cat evidence/live_moisture.json | python3 -c "import sys, json; print(json.load(sys.stdin)['moisture_pct'])")
    BAR_SIZE=$(( MOISTURE / 5 ))
    printf "  • Soil Moisture: ["
    for ((i=0; i<20; i++)); do
        if [ $i -lt $BAR_SIZE ]; then printf "${GREEN}#${RESET}"; else printf "."; fi
    done
    printf "] ${MOISTURE}%%\n"
fi

# Heartbeat Safety Check
if [ -f "evidence/watchdog_heartbeat.txt" ]; then
    LAST_PULSE=$(cat evidence/watchdog_heartbeat.txt)
    PULSE_TS=$(date -j -f "%Y-%m-%d %H:%M:%S" "$LAST_PULSE" +%s)
    NOW=$(date +%s)
    DIFF=$(( (NOW - PULSE_TS) / 60 ))
    
    if [ $DIFF -gt 20 ]; then
        echo -e "  • Watchdog Pulse: ${RED}STALE ($DIFF min ago)${RESET}"
    TOP_REPO=$(python3 -c "import json; print(json.load(open("evidence/trending_artifacts.json"))["artifacts"][0]["fullName"])") 
    echo -e "  • Top Discovery: ${YELLOW}$TOP_REPO${RESET}"    else
        echo -e "  • Watchdog Pulse: ${CYAN}ACTIVE ($DIFF min ago)${RESET}"
    TOP_REPO=$(python3 -c "import json; print(json.load(open("evidence/trending_artifacts.json"))["artifacts"][0]["fullName"])") 
    echo -e "  • Top Discovery: ${YELLOW}$TOP_REPO${RESET}"    fi
fi

# 3. Biological Countdown
echo -e "\n${GREEN}[ BIOLOGICAL ASSETS ]${RESET}"
HARVEST_DATE=$(python3 forecast-harvest.py | grep "Chickpea" | awk '{print $5}')
echo -e "  • ${YELLOW}Chico Chickpea:${RESET} 99 Days until Harvest ($HARVEST_DATE)"

echo -e "${CYAN}====================================================${RESET}"
echo -e "COMMANDS: [ status ] [ vibe-log ] [ ./watchdog.sh ]"
