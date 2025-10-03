#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Directory
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📂
# @raycast.needsConfirmation false

# Documentation:
# @raycast.author bryanbuchanan
# @raycast.authorURL https://raycast.com/bryanbuchanan

PREFIX="~/Library/CloudStorage/Dropbox-ERAMoto/ERA File Server"
CLIPBOARD=$(pbpaste)
CLIPBOARD=${CLIPBOARD//#/} # Remove '#' from order number, if present
FULL_PATH="${PREFIX}/${CLIPBOARD#$PREFIX}" # Removes potential duplicate "prefixes" in directory path
mkdir -p "$(eval echo ${FULL_PATH})" && open "$(eval echo ${FULL_PATH})"

