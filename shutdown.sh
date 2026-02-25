#!/bin/bash
# 🛡️ FogSift Secure Shutdown (v2.0 - Integrated)
echo "🛡️ Initiating FogSift Secure Shutdown..."
echo "--------------------------------------"

# 1. Run the Snapshot Engine
if [ -f "./snapshot.sh" ]; then
    ./snapshot.sh
fi

# 2. Run the Vibe-Logger
if [ -f "./vibe-log.sh" ]; then
    ./vibe-log.sh
fi

# 3. Check for any changes
CHANGES=$(git status --porcelain)

if [ -n "$CHANGES" ]; then
    echo "⚠️ WARNING: Uncommitted changes or snapshots detected!"
    echo "$CHANGES"
    echo "--------------------------------------"
    printf "Sync to the FogSift Registry? (y/n): "
    read -r REPLY
    if [ "$REPLY" = "y" ] || [ "$REPLY" = "Y" ]; then
        printf "Enter commit message: "
        read -r MSG
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
