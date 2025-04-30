#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Browser: ERA
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔺

tell application "System Events"
	tell process "Brave Browser" to tell menu bar 1
		click menu item "ERA" of menu 1 of menu bar item "Profiles"
	end tell
	log "Switched to ERA profile"
end tell
