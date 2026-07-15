#!/usr/bin/env zsh

# get theme
if [[ -L ~/.config/themes/current ]]; then
  theme_name=$(basename -- "$(readlink ~/.config/themes/current)" .conf)
  wallpaper_dir="$HOME/Wallpapers/$theme_name"
else
  echo "No current theme set. Using default wallpaper directory"
  wallpaper_dir="$HOME/Wallpapers"
fi

# fallback if missing
if [[ ! -d "$wallpaper_dir" ]]; then
  theme_name=$(basename "$(readlink ~/.config/themes/current)" .conf)
  notify-send "$theme_name wallpaper directory not found:" "$wallpaper_dir"
  ~/.local/bin/random-wallpaper
  exit 0
fi

# pick wallpaper safely
new_wall=$(
  find "$wallpaper_dir" -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) |
    shuf -n1
)

if [[ -z "$new_wall" ]]; then
  notify-send "No wallpapers found in:" "$wallpaper_dir"
  exit 1
fi

# Set wallpaper (swaybg)
pkill -x swaybg 2>/dev/null
swaybg -i "$new_wall" -m fill &

# Uncomment if you switch back to awww/swww
# awww img "$new_wall"

# notification
notify-send "Wallpaper changed" "$(basename "$new_wall")"
