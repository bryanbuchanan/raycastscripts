# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal collection of [Raycast Script Commands](https://github.com/raycast/script-commands). Each file in `scripts/` is a standalone, self-contained script that Raycast discovers and runs directly — there is no build, lint, or test step. To test a script, run it directly (e.g. `./scripts/whois.sh`) or invoke it through Raycast.

## Script conventions

Every script must start with the Raycast metadata comment block after the shebang:

```
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title <Title>
# @raycast.mode silent

# Optional parameters:
# @raycast.icon <emoji>
```

Existing scripts all use `@raycast.mode silent`. Optional fields like `@raycast.packageName`, `@raycast.description`, and `@raycast.author` appear in some scripts (see `scripts/fix-zed-merge-windows.sh`).

Three languages are in use, distinguished by shebang:
- Bash (`#!/bin/bash`)
- AppleScript (`#!/usr/bin/osascript`) — used for macOS UI automation (menu clicking via System Events, browser profile switching)
- Node.js (`#!/opt/homebrew/bin/node`) — note the Homebrew path, not `/usr/bin/env node`; `.mjs` extension with ES modules

## Common patterns

- Scripts typically read input from the clipboard (`pbpaste`), extract what they need with a regex (`grep -E -o ... | head -n 1`), and exit 1 silently if nothing matches.
- Output is either opening a URL (`open "https://..."`) or writing a result back to the clipboard (`pbcopy`).
- The `browserprofile-*.applescript` scripts are near-identical variants that switch Brave Browser profiles via the menu bar; keep them in sync if changing one.

## Dependencies

`package.json` exists only for the `sharp` dependency (image processing); no script currently in this repo imports it — scripts that used it have moved to other repos. There are no npm scripts.
