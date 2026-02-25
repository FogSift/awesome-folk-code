#!/bin/bash
# 🏆 FogSift Victory Publisher v2.0
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "🏆 Syncing Node Intelligence to Public README..."

# 1. Gather Data
MOISTURE=$(cat "$DIR/evidence/live_moisture.json" | python3 -c "import sys, json; print(json.load(sys.stdin)['moisture_pct'])")
INTEL=$(cat "$DIR/evidence/tech_context.txt" | head -n 1)

# 2. Update README (Maintain header, replace footer)
sed -i '' '/### 📡 Node Intelligence/,$d' README.md

echo -e "### 📡 Node Intelligence\n" >> README.md
echo -e "**Current Moisture:** $MOISTURE%  " >> README.md
echo -e "**Latest Discovery:** $INTEL  " >> README.md
echo -e "**Last Sync:** $(date)  " >> README.md

echo "✅ README updated."
./shutdown.sh -y -m "Auto-Sync: Node Intelligence Update" -v "Published latest moisture and research stats."
