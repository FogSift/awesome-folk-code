#!/bin/bash
echo "📂 Re-mapping the Artifact Inventory..."
INDEX_FILE="artifacts/INDEX.md"
mkdir -p artifacts

echo "# 🗺️ Master Artifact Index" > $INDEX_FILE
echo "> A living map of every system deployed within the FogSift ecosystem." >> $INDEX_FILE
echo "" >> $INDEX_FILE
echo "| Project Name | Vibe | Status |" >> $INDEX_FILE
echo "| :--- | :--- | :--- |" >> $INDEX_FILE

for d in artifacts/*/ ; do
    [ -e "$d" ] || continue
    if [ -f "${d}README.md" ]; then
        NAME=$(grep -m 1 "^# 🏺" "${d}README.md" | sed 's/# 🏺 Artifact: //')
        # Fix: Capture the exact line starting with >
        VIBE=$(grep "^>" "${d}README.md" | sed 's/^> //')
        DIR=$(basename "$d")
        echo "| [$NAME](./$DIR/README.md) | $VIBE | 🟢 ACTIVE |" >> $INDEX_FILE
    fi
done
echo -e "\n---\n*Last updated: $(date)*" >> $INDEX_FILE
echo "✅ Master Index corrected."
