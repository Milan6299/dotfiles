#!/usr/bin/env zsh

# Set random wallpaper
WALLPAPER_DIR="$HOME/Wallpapers/"
NEW_WALL=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" \) | shuf -n1)
#MONITOR=$(hyprctl monitors | grep "Monitor" | head -n1 | awk '{print $2}')

# Kill and restart hyprpaper to prevent memory leaks
pkill -x hyprpaper
sleep 0.1

# Start fresh
hyprpaper &
sleep 0.2
hyprctl hyprpaper preload "$NEW_WALL"
sleep 0.1
hyprctl hyprpaper wallpaper ",$NEW_WALL" #add $MONITOR before $NEW_WALL to specify monitors
