#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Directory
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📂
# @raycast.needsConfirmation false

# Documentation:
# @raycast.author bryanbuchanan
# @raycast.authorURL https://raycast.com/bryanbuchanan

PREFIX="${HOME}/Library/CloudStorage/Dropbox-ERAMoto/ERA File Server"
CLIPBOARD=$(pbpaste)
CLIPBOARD=${CLIPBOARD//#/} # Remove '#' from order number, if present
FULL_PATH="${PREFIX}/${CLIPBOARD#$PREFIX}" # Removes potential duplicate "prefixes" in directory path

# Extract the first folder from clipboard path
FIRST_FOLDER="${CLIPBOARD%%/*}"
FIRST_FOLDER_PATH="${PREFIX}/${FIRST_FOLDER}"

# Make sure the first folder of the copied path exists
if [ ! -d "$FIRST_FOLDER_PATH" ]; then
	echo "Directory doesn't exist"
	exit 0
fi

mkdir -p "$(eval echo ${FULL_PATH})" && open "$(eval echo ${FULL_PATH})"

