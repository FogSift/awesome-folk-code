#!/bin/bash
# 🖥️ FogSift Mission Control Dashboard

# Colors for the vibe
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

clear
echo -e "${CYAN}====================================================${RESET}"
echo -e "${CYAN}         🌫️  FOGSIFT REGISTRY: MISSION CONTROL       ${RESET}"
echo -e "${CYAN}====================================================${RESET}"

# 1. Identity Section
USER=$(gh api user -q .login)
echo -e "${YELLOW}[ ARCHITECT ]${RESET} @$USER"

# 2. System Vibe
VIBE=$(tail -n 3 evidence/architect_logs.md | grep "Vibe:" | cut -d ':' -f 2)
echo -e "${YELLOW}[ LAST VIBE ]${RESET} $VIBE"

echo -e "${CYAN}----------------------------------------------------${RESET}"

# 3. Biological Intelligence
echo -e "${GREEN}[ BIOLOGICAL ASSETS ]${RESET}"
if [ -f "evidence/seed_inventory.csv" ]; then
    COUNT=$(tail -n +2 evidence/seed_inventory.csv | wc -l | xargs)
    echo "  • Total Assets: $COUNT"
    python3 forecast-harvest.py | grep "🌿" | sed 's/🌿/  •/'
else
    echo "  • No assets detected."
fi

echo -e "${CYAN}----------------------------------------------------${RESET}"

# 4. Git & Sync Status
echo -e "${GREEN}[ REGISTRY HEALTH ]${RESET}"
UNTRACKED=$(git status --porcelain | wc -l | xargs)
if [ "$UNTRACKED" -eq "0" ]; then
    echo -e "  • Status: ${GREEN}FULLY SYNCED${RESET}"
else
    echo -e "  • Status: ${YELLOW}$UNTRACKED UNCOMMITTED CHANGES${RESET}"
fi

LAST_SYNC=$(git log -1 --format=%cr)
echo "  • Last Transmit: $LAST_SYNC"

echo -e "${CYAN}====================================================${RESET}"
echo -e "Commands: [ garage ] [ vibe-log ] [ shutdown ]"
