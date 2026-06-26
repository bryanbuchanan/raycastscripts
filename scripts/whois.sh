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

# Strip any subdomains (including www) down to the registrable domain.
# Handles common multi-part TLDs (e.g. example.co.uk) by keeping three labels.
case "$DOMAIN" in
	*.co.uk|*.org.uk|*.me.uk|*.gov.uk|*.ac.uk|*.com.au|*.net.au|*.org.au|*.co.nz|*.co.za|*.com.br|*.co.jp)
		DOMAIN=$(echo "$DOMAIN" | grep -E -o "[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$")
		;;
	*)
		DOMAIN=$(echo "$DOMAIN" | grep -E -o "[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$")
		;;
esac

# Open the RDAP lookup (modern WHOIS) for the domain
open "https://client.rdap.org/?type=domain&object=$DOMAIN"
