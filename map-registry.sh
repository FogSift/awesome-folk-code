#!/bin/bash
# 🗺️ FogSift Registry Map Generator

MAP_FILE="ARCHITECTURE.md"

echo "# 🏛️ FogSift Registry: Architecture Map" > $MAP_FILE
echo "> Automated visual mapping of the local operational node." >> $MAP_FILE
echo -e "\n\`\`\`mermaid" >> $MAP_FILE
echo "graph TD" >> $MAP_FILE

# Define the Nodes
echo "  subgraph Intelligence[The Brain]" >> $MAP_FILE
echo "    FH[forecast-harvest.py] --> SI[seed_inventory.csv]" >> $MAP_FILE
echo "    FH --> DB[Mission Control Dashboard]" >> $MAP_FILE
echo "  end" >> $MAP_FILE

echo "  subgraph Operations[The Gear]" >> $MAP_FILE
echo "    SH[shutdown.sh] --> SNAP[snapshot.sh]" >> $MAP_FILE
echo "    SH --> VL[vibe-log.sh]" >> $MAP_FILE
echo "    SH --> GH[GitHub Organization]" >> $MAP_FILE
echo "  end" >> $MAP_FILE

echo "  subgraph Physical[The Field]" >> $MAP_FILE
echo "    FW[gear/firmware/main.py] --> SN[Soil Sensors]" >> $MAP_FILE
echo "  end" >> $MAP_FILE

echo "\`\`\`" >> $MAP_FILE
echo -e "\n--- \n*Generated: $(date)*" >> $MAP_FILE

echo "✅ Registry Map generated at $MAP_FILE"
