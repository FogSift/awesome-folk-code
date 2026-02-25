#!/bin/bash

# 📸 FogSift Gallery Generator
echo "🖼️ Developing visual evidence..."

GALLERY_FILE="evidence/GALLERY.md"

echo "# 📸 FogSift: Boots on the Ground" > $GALLERY_FILE
echo "> Visual proof of decentralized actuation and hardware pilots." >> $GALLERY_FILE
echo "" >> $GALLERY_FILE

# Search for common image formats in the evidence directory
for img in $(find evidence/backyard-pilots -name "*.jpg" -o -name "*.png" -o -name "*.webp"); do
    DIR=$(dirname "$img")
    USER=$(basename "$DIR")
    FILE=$(basename "$img")
    
    echo "### 🏺 Pilot: @$USER" >> $GALLERY_FILE
    echo "![Deployment by $USER](./backyard-pilots/$USER/$FILE)" >> $GALLERY_FILE
    
    if [ -f "$DIR/caption.md" ]; then
        cat "$DIR/caption.md" >> $GALLERY_FILE
    fi
    echo -e "\n---\n" >> $GALLERY_FILE
done

echo "✅ Gallery generated at evidence/GALLERY.md"
