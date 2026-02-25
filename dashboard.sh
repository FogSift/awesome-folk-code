#!/bin/bash
# 🖥️ FogSift Mission Control Dashboard v3.6 (Safety Guarded)

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

clear
echo -e "${CYAN}====================================================${RESET}"
echo -e "${CYAN}             ENVIRONMENTAL INTELLIGENCE             ${RESET}"
echo -e "${CYAN}====================================================${RESET}"

# 1. Weather & Biology
if [ -f "evidence/local_weather.json" ]; then
    TEMP=$(python3 -c "import json; print(json.load(open('evidence/local_weather.json'))['temp'])")
    echo -e "${YELLOW}[ WEATHER ]${RESET} Chico: $TEMP"
fi

# 2. System Status & Guard
echo -e "\n${GREEN}[ SYSTEM STATUS ]${RESET}"
if [ -f "evidence/live_moisture.json" ]; then
    MOISTURE=$(cat evidence/live_moisture.json | python3 -c "import sys, json; print(json.load(sys.stdin)['moisture_pct'])")
    printf "  • Soil Moisture: ["
    BAR_SIZE=$(( MOISTURE / 5 ))
    for ((i=0; i<BAR_SIZE; i++)); do printf "#"; done
    for ((i=BAR_SIZE; i<20; i++)); do printf "."; done
    printf "] ${MOISTURE}%%\n"
fi

if [ -f "evidence/guard_status.json" ]; then
    STATE=$(python3 -c "import json; print(json.load(open('evidence/guard_status.json'))['state'])")
    if [ "$STATE" == "PANIC" ]; then
        echo -e "  • Safety Guard:   ${RED}🚨 PANIC (LOCKOUT ACTIVE)${RESET}"
    else
        echo -e "  • Safety Guard:   ${GREEN}✅ CLEAR (OPERATIONAL)${RESET}"
    fi
fi

# 3. Research & Discovery
if [ -f "evidence/trending_artifacts.json" ]; then
    TOP_REPO=$(python3 -c "import json; print(json.load(open('evidence/trending_artifacts.json'))['artifacts'][0]['fullName'])")
    echo -e "  • Top Discovery:  ${YELLOW}$TOP_REPO${RESET}"
fi

echo -e "\n${CYAN}====================================================${RESET}"
echo -e "LOGS: [ status ] [ ./watchdog.sh ]"
