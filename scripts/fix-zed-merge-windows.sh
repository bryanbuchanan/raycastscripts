#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Fix Zed Merge Windows
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🪟
# @raycast.packageName Zed

# Documentation:
# @raycast.description Toggles use_system_window_tabs off and back on to fix Merge All Windows
# @raycast.author Bryan

FILE="$HOME/.config/zed/settings.json"

/usr/bin/sed -i '' 's/"use_system_window_tabs": true/"use_system_window_tabs": false/' "$FILE"
sleep 1
/usr/bin/sed -i '' 's/"use_system_window_tabs": false/"use_system_window_tabs": true/' "$FILE"
