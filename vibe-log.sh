#!/bin/bash
# 🎙️ FogSift Qualitative Vibe-Logger
echo "🌫️ Accessing the Architect's Log..."

LOG_FILE="evidence/architect_logs.md"

# Initialize if missing
if [ ! -f "$LOG_FILE" ]; then
    echo "# 🎙️ Architect's Log: FogSift Registry" > "$LOG_FILE"
    echo "> Qualitative notes on the movement." >> "$LOG_FILE"
fi

echo "--------------------------------------"
read -p "Current Vibe (e.g., High-Energy, Foggy, Focused): " VIBE
read -p "Log Entry (What's on your mind?): " ENTRY

TIMESTAMP=$(date "+%Y-%m-%d %H:%M")

{
    echo -e "\n## $TIMESTAMP"
    echo "* **Vibe:** $VIBE"
    echo "* **Entry:** $ENTRY"
    echo "---"
} >> "$LOG_FILE"

echo "--------------------------------------"
echo "✅ Log entry secured in $LOG_FILE"
