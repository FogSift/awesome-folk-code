#!/bin/bash
# 🖥️ FogSift Mission Control v5.5 (Visual Sparkline)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

clear
echo -e "${CYAN}====================================================${RESET}"
echo -e "${CYAN}             ENVIRONMENTAL INTELLIGENCE             ${RESET}"
echo -e "${CYAN}====================================================${RESET}"

# 1. System Status & Visual Trend
if [ -f "$DIR/evidence/live_moisture.json" ]; then
    MOISTURE=$(cat "$DIR/evidence/live_moisture.json" | python3 -c "import sys, json; print(json.load(sys.stdin)['moisture_pct'])")
    echo -e "${GREEN}[ SYSTEM ]${RESET} Soil: ${MOISTURE}%"
    
    if [ -f "$DIR/evidence/moisture_history.txt" ]; then
        # Map numbers to ASCII bars: 1-25: , 26-50: ▃, 51-75: ▆, 76-100: █
        SPARK=$(tail -n 5 "$DIR/evidence/moisture_history.txt" | python3 -c "
import sys
for line in sys.stdin:
    v = int(line.strip())
    if v < 40: print(' ', end='')
    elif v < 60: print('▃', end='')
    elif v < 80: print('▆', end='')
    else: print('█', end='')
")
        echo -e "  • Trend: [ $SPARK ]"
    fi
fi

# 2. Intel Brief (Path Corrected)
echo -e "\n${YELLOW}[ LATEST RESEARCH ARCHIVE ]${RESET}"
JOURNAL="$DIR/evidence/research_journal.md"
if [ -s "$JOURNAL" ]; then
    # Grab the last 3 lines that aren't headers or separators
    tail -n 15 "$JOURNAL" | grep -vE "^#|---" | grep . | tail -n 3 | sed 's/^/  • /'
else
    echo -e "  • ${CYAN}[!] Sifter Brief Pending... Run ./watchdog.sh${RESET}"
fi

echo -e "\n${GREEN}[ BIOLOGICAL ASSETS ]${RESET}"
HARVEST_DATE=$(python3 forecast-harvest.py | grep "Chickpea" | awk '{print $5}' 2>/dev/null)
echo -e "  • Chico Chickpea: 99 Days until Harvest ($HARVEST_DATE)"

echo -e "${CYAN}====================================================${RESET}"
echo -e "COMMANDS: [ status ] [ ./watchdog.sh ] [ ./claim-victory.sh ]"
