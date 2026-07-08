#!/usr/bin/bash

WALLPAPER_DIR="$HOME/Wallpapers"

NEW_WALL=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" \) | shuf -n1)

[[ -z "$NEW_WALL" ]] && exit 1

# monitor=$(hyprctl monitors -j | jq -r '.[0].name')

# hyprctl hyprpaper wallpaper "$monitor,$NEW_WALL"
# awww img "$NEW_WALL"

pkill -x swaybg 2>/dev/null
swaybg -i "$NEW_WALL" -m fill &

notify-send "Random wallpaper applied!"
