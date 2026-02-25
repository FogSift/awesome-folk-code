import csv
import os
from datetime import datetime, timedelta

# 📈 FogSift Supply Chain Forecaster v2.3
SEED_LOG = "evidence/seed_inventory.csv"

# Days to Maturity (DTM) dictionary
DTM_MAP = {
    "Chickpea": 100,
    "Tomato": 80,
    "Basil": 45,
    "Default": 60
}

def get_projections():
    if not os.path.exists(SEED_LOG):
        return "❌ Error: No seed inventory found."

    projections = []
    with open(SEED_LOG, mode='r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            # Explicit mapping to prevent column shifting errors
            # We strip whitespace from keys and values
            clean_row = {str(k).strip(): str(v).strip() for k, v in row.items() if k is not None}
            
            variety = clean_row.get('Variety')
            plant_date_str = clean_row.get('Plant_Date')
            
            if not variety or not plant_date_str:
                continue

            dtm = int(DTM_MAP.get(variety, DTM_MAP["Default"]))
            
            try:
                # Attempt to parse the date
                plant_date = datetime.strptime(plant_date_str, '%Y-%m-%d')
                harvest_date = plant_date + timedelta(days=dtm)
                projections.append(f"🌿 {variety}: Expected Harvest {harvest_date.strftime('%Y-%m-%d')} (DTM: {dtm})")
            except ValueError:
                projections.append(f"⚠️ {variety}: Invalid date format found: '{plant_date_str}'")
    
    return "\n".join(projections) if projections else "📭 No valid entries found."

def main():
    print("\n--- FOGSIFT YIELD INTELLIGENCE ---")
    print(get_projections())
    print("----------------------------------\n")

if __name__ == "__main__":
    main()
