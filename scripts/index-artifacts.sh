#!/bin/bash
echo "📂 Re-mapping the Artifact Inventory..."
INDEX_FILE="artifacts/INDEX.md"
mkdir -p artifacts

# Initialize the file
cat << INNER_EOF > $INDEX_FILE
# 🗺️ Master Artifact Index
> A living map of every system deployed within the FogSift ecosystem.

| Project Name | Vibe | Status |
| :--- | :--- | :--- |
INNER_EOF

# Loop through artifact directories
for d in artifacts/*/ ; do
    [ -e "$d" ] || continue
    if [ -f "${d}README.md" ]; then
        NAME=$(grep -m 1 "^# 🏺" "${d}README.md" | sed 's/# 🏺 Artifact: //')
        VIBE=$(grep "^>" "${d}README.md" | sed 's/^> //')
        DIR=$(basename "$d")
        echo "| [$NAME](./$DIR/README.md) | $VIBE | 🟢 ACTIVE |" >> $INDEX_FILE
    fi
done

echo -e "\n---\n*Last updated: $(date)*" >> $INDEX_FILE
echo "✅ Master Index synchronized."
