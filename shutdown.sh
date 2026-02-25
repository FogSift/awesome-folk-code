#!/bin/bash
# 🛡️ FogSift Secure Shutdown Protocol
echo "🛡️ Initiating FogSift Secure Shutdown..."
echo "--------------------------------------"

# Check for any changes (tracked or untracked)
CHANGES=$(git status --porcelain)

if [ -n "$CHANGES" ]; then
    echo "⚠️ WARNING: Uncommitted changes or untracked files detected!"
    echo "$CHANGES"
    echo "--------------------------------------"
    printf "Do you want to sync these to the Registry? (y/n): "
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
