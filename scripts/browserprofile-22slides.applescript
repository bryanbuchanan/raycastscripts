#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Browser: 22Slides
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📷

set targetBrowser to "Brave Browser"

tell application "System Events"
	set frontApp to name of first application process whose frontmost is true
end tell

if frontApp is not targetBrowser then
	return
end if

tell application "System Events"
	tell process targetBrowser to tell menu bar 1
		click menu item "22Slides" of menu 1 of menu bar item "Profiles"
	end tell
	log "Switched to 22Slides profile"
end tell
