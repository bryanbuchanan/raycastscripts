#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Get Largest Resolution
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖼️

# Documentation:
# @raycast.description Parses an <img> tag on the clipboard, downloads its largest srcset version, and copies the image to the clipboard
# @raycast.author Bryan

INPUT=$(pbpaste)

# Pull the srcset attribute out of the tag
SRCSET=$(echo "$INPUT" | grep -E -o 'srcset="[^"]*"' | head -n 1 | sed 's/^srcset="//; s/"$//')

if [ -n "$SRCSET" ]; then
	# Entries are "url NNNw" separated by commas; pick the largest width
	URL=$(echo "$SRCSET" | tr ',' '\n' | awk '{w=$2; sub(/w$/,"",w); print w "\t" $1}' | sort -rn | head -n 1 | cut -f2)
else
	# No srcset — fall back to src
	URL=$(echo "$INPUT" | grep -E -o 'src="[^"]*"' | head -n 1 | sed 's/^src="//; s/"$//')
fi

if [ -z "$URL" ]; then
	echo "No image URL found on clipboard"
	exit 1
fi

# Decode HTML entities in the URL
URL=$(echo "$URL" | sed 's/&amp;/\&/g')

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

RAW="$TEMP_DIR/image"
if ! curl -fsSL "$URL" -o "$RAW"; then
	echo "Download failed"
	exit 1
fi

# Convert to PNG (clipboard can't hold webp) and copy
PNG="$TEMP_DIR/image.png"
if ! sips -s format png "$RAW" --out "$PNG" > /dev/null 2>&1; then
	echo "Could not convert image"
	exit 1
fi

osascript -e "set the clipboard to (read (POSIX file \"$PNG\") as «class PNGf»)"

WIDTH=$(sips -g pixelWidth "$PNG" | awk '/pixelWidth/{print $2}')
echo "Copied image (${WIDTH}px wide)"
