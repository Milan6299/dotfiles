#!/bin/bash

unset SSH_ASKPASS
unset SSH_ASKPASS_REQUIRE
KEYFILE="$HOME/.ssh/github_ed25519"

# Start SSH agent if not already running
if [ -z "$SSH_AUTH_SOCK" ] || ! [ -S "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" >/dev/null
fi

# Ensure keyfile exists
if [ ! -f "$KEYFILE" ]; then
  notify-send "SSH Key Missing" "Key file not found: $KEYFILE"
  exit 1
fi

# If agent has no keys, add the key
if ! ssh-add -l >/dev/null 2>&1; then

  PASSPHRASE=$(gum input --password --placeholder "Enter SSH passphrase")

  if [ -z "$PASSPHRASE" ]; then
    notify-send "SSH Agent" "Passphrase input cancelled"
    exit 1
  fi

  # Add key using piped passphrase
  ssh-add "$KEYFILE" <<<"$PASSPHRASE"

  # Clear passphrase variable from memory
  unset PASSPHRASE
fi

exit 0
