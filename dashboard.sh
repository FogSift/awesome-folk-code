#!/bin/bash
# 🖥️ FogSift Mission Control Dashboard v2.0

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

clear
# ASCII Banner
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

# 1. Local Weather (Chico, CA)
echo -e "${YELLOW}[ LOCAL WEATHER ]${RESET}"
# Using wttr.in for a quick, terminal-friendly weather snippet
curl -s "wttr.in/Chico?format=3" || echo "  • Weather signal lost."

# 2. Biological Countdown
echo -e "\n${GREEN}[ BIOLOGICAL ASSETS ]${RESET}"
if [ -f "evidence/seed_inventory.csv" ]; then
    # Calculate days remaining for the Chickpea specifically
    HARVEST_DATE=$(python3 forecast-harvest.py | grep "Chickpea" | awk '{print $4}')
    if [ -n "$HARVEST_DATE" ]; then
        TODAY=$(date +%s)
        TARGET=$(date -j -f "%Y-%m-%d" "$HARVEST_DATE" +%s 2>/dev/null || date -d "$HARVEST_DATE" +%s)
        DIFF=$(( (TARGET - TODAY) / 86400 ))
        echo -e "  • ${YELLOW}Chico Chickpea:${RESET} $DIFF Days until Harvest ($HARVEST_DATE)"
    fi
else
    echo "  • No biological signals detected."
fi

echo -e "${CYAN}----------------------------------------------------${RESET}"

# 3. Registry Health
echo -e "${GREEN}[ REGISTRY HEALTH ]${RESET}"
UNTRACKED=$(git status --porcelain | wc -l | xargs)
STATUS=$([ "$UNTRACKED" -eq "0" ] && echo -e "${GREEN}OPTIMAL${RESET}" || echo -e "${YELLOW}DIRTY ($UNTRACKED changes)${RESET}")
echo -e "  • Node Status: $STATUS"
echo "  • Last Transmit: $(git log -1 --format=%cr)"

echo -e "${CYAN}====================================================${RESET}"
echo -e "LOGS: [ status ] [ vibe-log ] [ shutdown -y -m '...' ]"
