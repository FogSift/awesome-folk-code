#!/bin/bash

# 🏆 The Champion's Rite
# Automates adding an initiate to the Hall of Champions.

echo "🛡️ Initiating Victory Protocol..."

# Ensure the user provides a title (e.g., "The Alchemist")
if [ -z "$1" ]; then
    echo "❌ Error: You must provide a Title. Usage: ./claim-victory.sh 'Your Title'"
    exit 1
fi

USER_HANDLE=$(gh api user -q .login)
DATE_STAMP=$(date +%Y-%m-%d)
TITLE=$1

# Create a new branch
git checkout -b champ-$USER_HANDLE

# Append to the leaderboard
echo "| @$USER_HANDLE | $DATE_STAMP | $TITLE |" >> LEADERBOARD.md

# Commit and push
git add LEADERBOARD.md
git commit -m "New Champion: @$USER_HANDLE ($TITLE)"
git push -u origin HEAD

# Open the PR
gh pr create --title "🏆 New Champion: @$USER_HANDLE" --body "I have navigated the Labyrinth, defeated the Minotaur, and recovered the lost logic."

echo "✅ Victory recorded. Awaiting Architect review."
