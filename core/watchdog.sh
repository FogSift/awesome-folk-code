#!/bin/bash
echo "📡 Watchdog initiated..."
python3 scripts/pipeline/trend-sifter.py
python3 scripts/pipeline/extract-context.py
python3 scripts/pipeline/curate-intel.py
echo "✅ Cycle complete. Run ./status"
