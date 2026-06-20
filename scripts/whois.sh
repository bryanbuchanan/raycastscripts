#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Whois Lookup
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔍

INPUT=$(pbpaste)

# Extract first domain name using regex
DOMAIN=$(echo "$INPUT" | grep -E -o "[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z]{2,}" | head -n 1)

# Exit if no domain is found
if [ -z "$DOMAIN" ]; then
	exit 1
fi

# Open the RDAP lookup (modern WHOIS) for the domain
open "https://client.rdap.org/?type=domain&object=$DOMAIN"
