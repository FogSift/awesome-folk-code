#!/bin/bash
# 🖥️ FogSift Mission Control Dashboard v2.7 (Hardened)

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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
echo -e "${YELLOW}[ LOCAL WEATHER ]${RESET}"
python3 sensors/weather_bridge.py
if [ -f "evidence/local_weather.json" ]; then
    TEMP=$(python3 -c "import json; print(json.load(open('evidence/local_weather.json'))['temp'])")
    DESC=$(python3 -c "import json; print(json.load(open('evidence/local_weather.json'))['desc'])")
    echo "  • Chico, CA: $DESC | $TEMP"
else
    echo "  • Weather signal lost."
fi

# 2. System Status & Actuation
echo -e "\n${GREEN}[ SYSTEM STATUS ]${RESET}"
python3 sensors/bridge.py > /dev/null
if [ -f "evidence/live_moisture.json" ]; then
    MOISTURE=$(cat evidence/live_moisture.json | python3 -c "import sys, json; print(json.load(sys.stdin)['moisture_pct'])")
    BAR_SIZE=$(( MOISTURE / 5 ))
    printf "  • Soil Moisture: ["
    for ((i=0; i<20; i++)); do
        if [ $i -lt $BAR_SIZE ]; then printf "${GREEN}#${RESET}"; else printf "."; fi
    done
    printf "] ${MOISTURE}%%\n"
fi

if [ -f "evidence/watchdog_heartbeat.txt" ]; then
    echo -e "  • Watchdog Pulse: ${CYAN}$(cat evidence/watchdog_heartbeat.txt)${RESET}"
fi

if [ -f "evidence/actuation_history.md" ]; then
    LAST_EVENT=$(tail -n 1 evidence/actuation_history.md)
    EVENT_TIME=$(echo "$LAST_EVENT" | cut -d '|' -f 2 | xargs)
    echo -e "  • Last Actuation: ${CYAN}$EVENT_TIME${RESET}"
fi

# 3. Biological Countdown
echo -e "\n${GREEN}[ BIOLOGICAL ASSETS ]${RESET}"
HARVEST_DATE=$(python3 forecast-harvest.py | grep "Chickpea" | awk '{print $5}')
if [ -n "$HARVEST_DATE" ]; then
    TARGET=$(date -j -f "%Y-%m-%d" "$HARVEST_DATE" +%s)
    TODAY=$(date +%s)
    DIFF=$(( (TARGET - TODAY) / 86400 ))
    echo -e "  • ${YELLOW}Chico Chickpea:${RESET} $DIFF Days until Harvest ($HARVEST_DATE)"
fi

echo -e "${CYAN}====================================================${RESET}"
echo -e "LOGS: [ status ] [ vibe-log ] [ ./claim-victory.sh ]"
