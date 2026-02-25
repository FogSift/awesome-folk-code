#!/bin/bash
# 🏆 FogSift Intel Publisher
echo "🏆 Publishing Intelligence to README..."

REPORT="evidence/INTEL_REPORT.md"

if [ ! -f "$REPORT" ]; then
    echo "❌ No curated report found. Running Sifter first..."
    python3 trend-sifter.py && python3 curate-intel.py
fi

# Use a temporary file to rebuild the README
# We keep the header and replace the Intel section
cat README.md | sed '/### 📡 Latest Intelligence/,$d' > README.tmp
cat "$REPORT" >> README.tmp
mv README.tmp README.md

echo "✅ README updated with latest trending artifacts."
./shutdown.sh -y -m "Auto-curation: Sync latest GitHub trending artifacts" -v "Sovereign research cycle complete."
