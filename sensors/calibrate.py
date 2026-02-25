import json
import os

CALIBRATION_FILE = "evidence/soil_calibration.json"

def run_calibration():
    print("🧪 FogSift Soil Calibration Utility")
    print("-----------------------------------")
    
    # In a real scenario, you'd submerge the sensor in water vs dry air
    # For now, we establish the baseline mapping logic
    dry_value = 3200  # Raw ADC in dry air
    wet_value = 1400  # Raw ADC in water
    
    config = {
        "sensor_type": "Capacitive_v1.2",
        "adc_min": wet_value,
        "adc_max": dry_value,
        "units": "percentage",
        "chico_baseline": 70 # Target moisture for chickpeas
    }
    
    with open(CALIBRATION_FILE, 'w') as f:
        json.dump(config, f, indent=2)
        
    print(f"✅ Calibration baseline secured in {CALIBRATION_FILE}")
    print(f"📈 Range: {wet_value} (100%) to {dry_value} (0%)")

if __name__ == "__main__":
    run_calibration()
