#!/bin/bash

echo "📝 Generating your latest Community Update..."
echo "-------------------------------------------"
echo ""

echo "🌟 NEW TO THE GARAGE 🌟"
echo "Here are the latest vibe-coded tools added to Awesome Folk Code:"
echo ""

# Use GitHub CLI to grab the 5 most recently merged Pull Requests, formatting them nicely
gh pr list --state merged --limit 5 --json title,author --jq '.[] | "- \(.title) (via @\(.author.login))"'

echo ""
echo "Want to add your own tool? Pass The Trial and join the community."
echo "🔗 github.com/FogSift/awesome-folk-code"
echo ""
echo "-------------------------------------------"
echo "✅ Copy the text above and paste it directly into Threads, X, or your newsletter."
