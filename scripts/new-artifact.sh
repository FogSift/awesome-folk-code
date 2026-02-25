#!/bin/bash

echo "🏗️ Generating Supply Chain Artifact Template..."

read -p "Project Name: " PROJ_NAME
read -p "One-sentence Vibe: " PROJ_VIBE

DIR_NAME=$(echo "$PROJ_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
mkdir -p "artifacts/$DIR_NAME"

cat << INNER_EOF > "artifacts/$DIR_NAME/README.md"
# 🏺 Artifact: $PROJ_NAME
> $PROJ_VIBE

## 🛠️ The Tech Stack
* **Logic:** (e.g., Claude 3.5 Sonnet)
* **Actuation:** (e.g., Python Script / iOS Shortcut)
* **Hardware:** (e.g., Local Mac / Raspberry Pi)

## 🌫️ FogSift Mapping
* **Upstream:** (Where the data comes from)
* **Downstream:** (Who uses the result)

## 🧭 Setup
1. (Step 1)
2. (Step 2)
INNER_EOF

echo "✅ Artifact directory created at artifacts/$DIR_NAME"
