#!/usr/bin/env bash
set -euo pipefail

CACHE_DIR="$HOME/.cache/tmux-sessionizer"
CACHE_FILE="$CACHE_DIR/sessions.db"

mkdir -p "$CACHE_DIR"

tmux list-sessions -F "#{session_name}" 2>/dev/null |
sort |
awk '{print NR "|" $0}' > "$CACHE_FILE"
