#!/bin/bash
# 📣 FogSift macOS Notifier
TITLE=$1
MESSAGE=$2

# Use AppleScript to trigger a native notification
osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\" sound name \"Crystal\""
