#!/bin/bash
# 📸 FogSift Registry Snapshot Engine
echo "🔍 Capturing Registry State..."

TIMESTAMP=$(date +%Y-%m-%d_%H-%M)
SNAPSHOT_DIR="snapshots/archive_$TIMESTAMP"
mkdir -p "$SNAPSHOT_DIR"

# 1. Capture the Biological State
if [ -f "evidence/seed_inventory.csv" ]; then
    cp "evidence/seed_inventory.csv" "$SNAPSHOT_DIR/"
    echo "🌱 Biological Assets captured."
fi

# 2. Capture the Intelligence State
python3 forecast-harvest.py > "$SNAPSHOT_DIR/yield_projection.txt"
echo "📈 Intelligence Projections captured."

# 3. Capture the System Vibe
./vibe-check.sh > "$SNAPSHOT_DIR/system_health.txt"
echo "🔮 System Health captured."

# 4. Generate the Manifest
{
    echo "FOGSIFT SNAPSHOT MANIFEST"
    echo "========================"
    echo "Captured: $TIMESTAMP"
    echo "Architect: @$(gh api user -q .login)"
    echo "Artifact Count: $(ls artifacts | wc -l | xargs)"
    echo "Registry Logic: $(git rev-parse HEAD)"
} > "$SNAPSHOT_DIR/MANIFEST.md"

echo "--------------------------------------"
echo "✅ Snapshot locked in: $SNAPSHOT_DIR"
