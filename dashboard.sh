#!/bin/bash
# 🖥️ FogSift Mission Control v5.0 (Beacon Edition)

# Absolute path resolution
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
RESET='\033[0m'

clear
echo -e "${CYAN}====================================================${RESET}"
echo -e "${CYAN}             ENVIRONMENTAL INTELLIGENCE             ${RESET}"
echo -e "${CYAN}====================================================${RESET}"

# 1. Weather & Biological Phase
if [ -f "$DIR/evidence/local_weather.json" ]; then
    TEMP=$(python3 -c "import json; print(json.load(open('$DIR/evidence/local_weather.json'))['temp'])")
    HOUR=$(date +%H)
    if [ $HOUR -ge 10 ] && [ $HOUR -le 18 ]; then 
        PHASE="${YELLOW}PEAK SUN (Evaporation High)${RESET}"
    else 
        PHASE="${BLUE}COOL PHASE (Hydration Optimal)${RESET}"
    fi
    echo -e "${YELLOW}[ ENVIRONMENT ]${RESET} Chico: $TEMP | $PHASE"
fi

# 2. System Status
echo -e "\n${GREEN}[ SYSTEM STATUS ]${RESET}"
if [ -f "$DIR/evidence/live_moisture.json" ]; then
    MOISTURE=$(cat "$DIR/evidence/live_moisture.json" | python3 -c "import sys, json; print(json.load(sys.stdin)['moisture_pct'])")
    GUARD=$(cat "$DIR/evidence/guard_status.json" | python3 -c "import json; print(json.load(open('$DIR/evidence/guard_status.json'))['state'])")
    
    printf "  • Soil Moisture: ["
    BAR_SIZE=$(( MOISTURE / 5 ))
    for ((i=0; i<20; i++)); do
        if [ $i -lt $BAR_SIZE ]; then printf "${GREEN}#${RESET}"; else printf "."; fi
    done
    printf "] ${MOISTURE}%%\n"
    
    if [ "$GUARD" == "PANIC" ]; then
        echo -e "  • Safety Guard:   ${RED}🚨 PANIC (LOCKOUT)${RESET}"
    else
        echo -e "  • Safety Guard:   ${GREEN}✅ OPERATIONAL${RESET}"
    fi
fi

# 3. Latest Intelligence Brief
echo -e "\n${CYAN}[ RESEARCH BRIEF ]${RESET}"
if [ -f "$DIR/evidence/tech_context.txt" ]; then
    sed 's/^/  • /' "$DIR/evidence/tech_context.txt"
else
    echo -e "  • ${BLUE}[!] Sifter Brief Pending...${RESET}"
fi

# 4. Biological Assets
echo -e "\n${GREEN}[ BIOLOGICAL ASSETS ]${RESET}"
HARVEST_DATE=$(python3 forecast-harvest.py | grep "Chickpea" | awk '{print $5}')
echo -e "  • Chico Chickpea: 99 Days until Harvest ($HARVEST_DATE)"

echo -e "${CYAN}====================================================${RESET}"
echo -e "COMMANDS: [ status ] [ ./watchdog.sh ] [ ./claim-victory.sh ]"
