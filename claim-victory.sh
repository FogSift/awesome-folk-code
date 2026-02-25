#!/bin/bash

# 🏆 The Champion's Rite
echo "🛡️ Initiating Victory Protocol..."

read -p "Enter your Champion Title (e.g., The Architect): " TITLE
USER_HANDLE=$(gh api user -q .login)
DATE_STAMP=$(date +%Y-%m-%d)

# Automate the Git Flow
git checkout -b victory-$USER_HANDLE
echo "| @$USER_HANDLE | $DATE_STAMP | $TITLE |" >> LEADERBOARD.md
git add LEADERBOARD.md
git commit -m "🏆 New Champion: @$USER_HANDLE"
git push -u origin victory-$USER_HANDLE

# Open the PR automatically
gh pr create --title "🏆 Hall of Champions: @$USER_HANDLE" --body "I have navigated the Labyrinth and secured the core."
