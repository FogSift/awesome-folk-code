#!/bin/bash
# 🧬 FogSift Seed Inventory Logger
echo "🌱 Initiating Genetic Asset Entry..."

DB_FILE="evidence/seed_inventory.csv"

# Initialize DB if missing
if [ ! -f "$DB_FILE" ]; then
    echo "Date,Variety,Source,Quantity,Plant_Date" > "$DB_FILE"
fi

read -p "Variety (e.g., Roma Tomato): " VARIETY
read -p "Source (e.g., Baker Creek): " SOURCE
read -p "Quantity (approx seeds): " QTY
read -p "Planting Target Date (YYYY-MM-DD): " PDATE

DATE=$(date +%Y-%m-%d)
echo "$DATE,$VARIETY,$SOURCE,$QTY,$PDATE" >> "$DB_FILE"

echo "--------------------------------------"
echo "✅ Asset Logged: $VARIETY"
echo "📊 Current Inventory Count: $(tail -n +2 $DB_FILE | wc -l)"
