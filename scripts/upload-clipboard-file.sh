#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Upload Clipboard File
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📤

# Documentation:
# @raycast.description With a file-open dialog frontmost, saves the clipboard image to a temp file and enters its path via Cmd+Shift+G
# @raycast.author Bryan

# Usage: click the file input on the website so the macOS open dialog appears,
# then trigger this script. If the clipboard holds a copied file, its path is
# used directly; if it holds image data, it's saved to a temp folder first.

TEMP_DIR="$HOME/.cache/clipboard-uploads"
mkdir -p "$TEMP_DIR"

# Clean up files older than a day
find "$TEMP_DIR" -type f -mtime +1 -delete 2>/dev/null

# If the clipboard contains a file reference (copied in Finder), use it directly
FILE_PATH=$(osascript -e 'POSIX path of (the clipboard as «class furl»)' 2>/dev/null)

# Otherwise save clipboard image data as a PNG
if [ -z "$FILE_PATH" ]; then
	FILE_PATH="$TEMP_DIR/clipboard-$(date +%Y%m%d-%H%M%S).png"
	osascript > /dev/null 2>&1 <<EOF
set pngData to the clipboard as «class PNGf»
set f to open for access POSIX file "$FILE_PATH" with write permission
set eof f to 0
write pngData to f
close access f
EOF
	if [ ! -s "$FILE_PATH" ]; then
		rm -f "$FILE_PATH"
		echo "No file or image on clipboard"
		exit 1
	fi
fi

# In the frontmost open dialog: Cmd+Shift+G, type the path, Return to go,
# Return again to click Open
osascript <<EOF
tell application "System Events"
	delay 0.3
	keystroke "g" using {command down, shift down}
	delay 0.4
	keystroke "$FILE_PATH"
	delay 0.2
	keystroke return
	delay 0.8
	keystroke return
end tell
EOF

echo "Uploaded $(basename "$FILE_PATH")"
