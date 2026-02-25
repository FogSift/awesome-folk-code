#!/bin/bash

# 📚 FogSift Wiki Deployment
echo "📡 Pushing tactical intel to the public Wiki..."

# Define temporary directory for the wiki clone
WIKI_DIR="/tmp/fogsift-wiki-sync"
rm -rf "$WIKI_DIR"

# Clone the actual Wiki repo (Requires Wiki to be enabled in settings first)
git clone https://github.com/FogSift/awesome-folk-code.wiki.git "$WIKI_DIR"

# Copy drafts into the Wiki repo
cp docs/wiki-drafts/*.md "$WIKI_DIR/"

# Commit and Push
cd "$WIKI_DIR"
git add .
git commit -m "Automatic sync from master repository docs/wiki-drafts"
git push origin master

echo "✅ Wiki synchronized and live."
