#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Eject Drives
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ⏏
# @raycast.needsConfirmation false

# Documentation:
# @raycast.author bryanbuchanan
# @raycast.authorURL https://raycast.com/bryanbuchanan

do shell script "diskutil list external | awk '/^\\s*\\/dev\\//{print $1}' | xargs -n1 diskutil eject"