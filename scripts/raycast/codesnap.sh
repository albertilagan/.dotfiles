#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title CodeSnap
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Language" }

# Documentation:
# @raycast.author albertilagan
# @raycast.authorURL https://raycast.com/albertilagan

/Users/albertilagan/.nix-profile/bin/silicon --from-clipboard -l $1 --to-clipboard