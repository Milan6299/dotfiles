#!/bin/bash

SRC="$HOME/.config/scripts"
DEST="$HOME/.local/bin"

mkdir -p "$DEST"

for f in "$SRC"/*.sh; do
  name=$(basename "$f" .sh)
  install -m 755 "$f" "$DEST/$name"
done
