#!/usr/bin/env bash

set -euo pipefail

dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"

mode="${1:-window}"
file="$dir/$(date +%F_%H-%M-%S).png"

declare -A msg=(
  [active]="Active window"
  [area]="Selected area"
  [screen]="Full screen"
  [window]="Selected Window"
)

[[ -v msg[$mode] ]] || {
  notify-send "Screenshot" "Invalid mode: $mode"
  exit 1
}

grimshot save "$mode" "$file"
wl-copy --type image/png <"$file"
notify-send -i "$file" "Screenshot Captured!" "${msg[$mode]} saved in $dir and copied to clipboard."
