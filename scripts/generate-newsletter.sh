#!/bin/bash
REPORT_DATE=$(date +%Y-%m-%d)
INDEX_FILE="artifacts/INDEX.md"
CHAMP_FILE="LEADERBOARD.md"

TOTAL_ARTIFACTS=$(ls -l artifacts | grep "^d" | wc -l | xargs)
LATEST_CHAMP=$(tail -n 1 "$CHAMP_FILE" | cut -d'|' -f2 | xargs)

echo "--- FOGSIFT INTELLIGENCE REPORT [$REPORT_DATE] ---"
echo "🛠️ GARAGE STATUS: ACTIVE"
echo "📊 TOTAL ARTIFACTS: $TOTAL_ARTIFACTS"
echo "🏆 CHAMPION OF THE WEEK: $LATEST_CHAMP"
echo ""
echo "🌟 LATEST SYSTEM UPDATES:"

# Improved grep to pull Name and Vibe
grep "^| \[" "$INDEX_FILE" | head -n 3 | while read -r line; do
    NAME=$(echo "$line" | cut -d"[" -f2 | cut -d"]" -f1)
    VIBE=$(echo "$line" | cut -d"|" -f3 | xargs)
    echo "- $NAME: $VIBE"
done

echo ""
echo "Mission: Re-syncing the core. Join us."
echo "🔗 github.com/FogSift/awesome-folk-code"
echo "--- END REPORT ---"
