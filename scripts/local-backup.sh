#!/bin/bash

echo "🗄️ Starting offline backup of Awesome Folk Code..."

# Step 1: Define where the backups will live (one folder up, so they don't get pushed to GitHub)
BACKUP_DIR="../fogsift-backups"
mkdir -p "$BACKUP_DIR"

# Step 2: Create a timestamp (e.g., 20260225_124500)
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/awesome-folk-code_backup_$TIMESTAMP.tar.gz"

# Step 3: Zip up the entire current directory (excluding the backup file itself if it were inside)
tar -czf "$BACKUP_FILE" .

echo "✅ Backup complete!"
echo "💾 Saved safely to your Mac at: $BACKUP_FILE"
