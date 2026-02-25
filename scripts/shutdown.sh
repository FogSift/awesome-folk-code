#!/bin/bash
# 🛡️ FogSift Secure Shutdown (v3.0 - Scriptable)

AUTO_YES=false
MSG=""
VIBE_ENTRY=""

# Parse flags
while getopts "ym:v:" opt; do
  case $opt in
    y) AUTO_YES=true ;;
    m) MSG="$OPTARG" ;;
    v) VIBE_ENTRY="$OPTARG" ;;
    *) echo "Usage: ./shutdown.sh [-y] [-m message] [-v vibe]"; exit 1 ;;
  esac
done

echo "🛡️ Initiating FogSift Secure Shutdown..."
echo "--------------------------------------"

# 1. Run the Snapshot Engine
if [ -f "./snapshot.sh" ]; then
    ./snapshot.sh
fi

# 2. Run the Vibe-Logger
if [ -f "./vibe-log.sh" ]; then
    if [ -n "$VIBE_ENTRY" ]; then
        # Automated vibe entry
        TIMESTAMP=$(date "+%Y-%m-%d %H:%M")
        {
            echo -e "\n## $TIMESTAMP"
            echo "* **Vibe:** Automated"
            echo "* **Entry:** $VIBE_ENTRY"
            echo "---"
        } >> evidence/architect_logs.md
        echo "✅ Log entry secured via flag."
    else
        ./vibe-log.sh
    fi
fi

# 3. Check for any changes
CHANGES=$(git status --porcelain)

if [ -n "$CHANGES" ]; then
    echo "⚠️ WARNING: Uncommitted changes or snapshots detected!"
    echo "$CHANGES"
    echo "--------------------------------------"
    
    if [ "$AUTO_YES" = false ]; then
        printf "Sync to the FogSift Registry? (y/n): "
        read -r REPLY
    else
        REPLY="y"
        echo "🤖 Auto-accepting sync..."
    fi

    if [ "$REPLY" = "y" ] || [ "$REPLY" = "Y" ]; then
        if [ -z "$MSG" ]; then
            printf "Enter commit message: "
            read -r MSG
        fi
        git add .
        git commit -m "sync: $MSG"
        git push origin main
        echo "✅ Changes transmitted to Upstream."
    else
        echo "🛑 Sync cancelled. Changes remain local."
    fi
else
    echo "✅ Workspace is clean. Performing final pull..."
    git pull origin main
fi

echo "--------------------------------------"
echo "Registry is SECURE. See you in the fog."
