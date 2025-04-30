#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Browser: 22Slides
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📷

tell application "System Events"
	tell process "Brave Browser" to tell menu bar 1
		click menu item "22Slides" of menu 1 of menu bar item "Profiles"
	end tell
	log "Switched to 22Slides profile"
end tell
