#!/bin/bash

echo ""
echo "🔮 Checking your FogSift Vibe 🔮"
echo "--------------------------------"

# Check for Git
if command -v git >/dev/null 2>&1; then
    echo "✅ Git is installed. You are ready to time-travel."
else
    echo "❌ Git is missing! You need Git to vibe code safely."
fi

# Check for GitHub CLI
if command -v gh >/dev/null 2>&1; then
    echo "✅ GitHub CLI (gh) is installed. No web UI needed!"
else
    echo "⚠️ GitHub CLI is missing. We highly recommend installing it so you can avoid GitHub's messy website."
fi

echo "--------------------------------"
echo "Run this anytime to ensure your workbench is ready."
echo ""
