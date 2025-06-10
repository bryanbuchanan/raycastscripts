#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title V1 Client Lookup
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔍

INPUT=$(pbpaste)

# Extract first email address using regex
EMAIL=$(echo "$INPUT" | grep -E -o "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" | head -n 1)

# Exit if no email is found
if [ -z "$EMAIL" ]; then
	exit 1
fi

# Open the URL with the email query
open "https://v1.22slides.com/tools/directory/details.php?email=$EMAIL"
