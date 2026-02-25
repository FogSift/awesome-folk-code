#!/bin/bash
# 🏆 FogSift Victory Publisher v2.1 (Hardened)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Ensure the Brief exists before publishing
if [ ! -f "$DIR/evidence/tech_context.txt" ]; then
    echo "⚠️ Tech brief missing. Running extractor..."
    python3 "$DIR/extract-context.py"
fi

MOISTURE=$(cat "$DIR/evidence/live_moisture.json" | python3 -c "import sys, json; print(json.load(sys.stdin)['moisture_pct'])")
INTEL=$(cat "$DIR/evidence/tech_context.txt" 2>/dev/null || echo "Research in progress...")

# Update README
sed -i '' '/### 📡 Node Intelligence/,$d' README.md
{
    echo "### 📡 Node Intelligence"
    echo ""
    echo "**Current Moisture:** $MOISTURE%  "
    echo "**Latest Discovery:** $INTEL  "
    echo "**Last Sync:** $(date)  "
} >> README.md

./shutdown.sh -y -m "Public Sync: Node State v2.1" -v "Published verified biological and research metrics."
