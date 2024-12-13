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

mkdir -p "$(eval echo $(pbpaste))" && open "$(eval echo $(pbpaste))"

