#!/bin/bash
# 🌫️ FogSift Tactical Gate v2.0

# 1. Check Weather Veto (Rain)
python3 scripts/pipeline/weather_gate.py
if [ $? -eq 1 ]; then
    echo "🚫 VETO: Rain forecasted. Standing down."
    exit 0
fi

# 2. Check Risk Level
python3 scripts/pipeline/analyze_risk.py
RISK_STATE=$?

if [ $RISK_STATE -eq 2 ]; then
    echo "🔥 PROACTIVE: Heatwave detected. Triggering preventative hydration."
    python3 scripts/pipeline/actuate.py
else
    # Fall back to standard threshold check
    python3 scripts/pipeline/actuate.py
fi
