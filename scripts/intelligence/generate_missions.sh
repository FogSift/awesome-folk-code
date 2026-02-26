#!/bin/zsh
# 📡 FogSift Intel Processor v2.1: Fixed Project Mapping

README="README.md"
PROJECT_NUMBER=2 # Use the short number for CLI commands

echo "🔍 Extracting intelligence from $README..."

grep "LINK: https://github.com" "$README" | while read -r line; do
    REPO_URL=$(echo "$line" | awk '{print $2}')
    REPO_NAME=$(echo "$REPO_URL" | sed 's/https:\/\/github.com\///')
    
    echo "🛰️ Found candidate: $REPO_NAME"
    # Search issues to see if mission exists
    EXISTS=$(gh issue list --search "$REPO_NAME" --json number --jq 'length')
    
    if [ "$EXISTS" -eq "0" ]; then
        echo "🚀 Launching Mission for $REPO_NAME..."
        ISSUE_URL=$(gh issue create \
            --title "MISSION: Curate $REPO_NAME" \
            --body "## Intel Report\nThe project at $REPO_URL was identified.\n\n## Objectives\n- [ ] Verify Folk Code status\n- [ ] Categorize\n- [ ] PR to README" \
            --label "mission")
        
        echo "📌 Pinning Mission to Project Board #$PROJECT_NUMBER..."
        gh project item-add $PROJECT_NUMBER --owner FogSift --url "$ISSUE_URL"
    else
        echo "✅ Mission already exists for $REPO_NAME. Skipping."
    fi
done
