#!/usr/bin/env zsh

# Get the current theme name safely
if [[ -L ~/.config/themes/current ]]; then
  THEME_NAME=$(basename $(readlink ~/.config/themes/current) .conf)
  WALLPAPER_DIR="$HOME/Wallpapers/$THEME_NAME"
else
  echo "No current theme set. Using default wallpaper directory."
  WALLPAPER_DIR="$HOME/Wallpapers"
fi

# Check if wallpaper directory exists
if [[ ! -d "$WALLPAPER_DIR" ]]; then
  notify-send "Wallpaper directory not found:" "$WALLPAPER_DIR"
  notify-send "Setting Random Wallpaper"
  $HOME/.config/hypr/scripts/random-wallpaper.sh
fi

# Find a random wallpaper
NEW_WALL=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) | shuf -n1)

# Check if we found any wallpapers
if [[ -z "$NEW_WALL" ]]; then
  notify-send "No wallpapers found in:" "$WALLPAPER_DIR"
  exit 1
fi

# Get monitor - use a more reliable method
#MONITOR=$(hyprctl monitors -j | jq -r '.[0].name' 2>/dev/null || hyprctl monitors | grep "Monitor" | head -n1 | awk '{print $2}')

# Kill and restart hyprpaper to prevent memory leaks
pkill -x hyprpaper
sleep 0.2

# Start fresh
hyprpaper &
sleep 0.3

# Set Wallpaper
hyprctl hyprpaper preload "$NEW_WALL"
sleep 0.1
hyprctl hyprpaper wallpaper ",$NEW_WALL" #add $MONITOR before $NEW_WALL to specify monitors
# Optional: Send notification
notify-send "Wallpaper Changed" "$(basename "$NEW_WALL")" -i "$NEW_WALL"
