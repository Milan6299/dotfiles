#!/usr/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/Wallpapers/"
CURRENT_WALLPAPER_FILE="$HOME/.cache/current_wallpaper"

# Find all image files
WALLPAPER_FILES=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) 2>/dev/null)

if [[ -z "$WALLPAPER_FILES" ]]; then
  notify-send "No wallpapers found" "Check: $WALLPAPER_DIR"
  exit 1
fi

# Get current wallpaper
if [[ -f "$CURRENT_WALLPAPER_FILE" ]]; then
  CURRENT_WALLPAPER_PATH=$(cat "$CURRENT_WALLPAPER_FILE")
  CURRENT_WALLPAPER_NAME=$(basename "$CURRENT_WALLPAPER_PATH")
else
  CURRENT_WALLPAPER_NAME=""
fi

# Build rofi menu
ROFI_MENU=""
while IFS= read -r WALLPAPER_PATH; do
  WALLPAPER_NAME=$(basename "$WALLPAPER_PATH")
  if [[ "$WALLPAPER_NAME" == "$CURRENT_WALLPAPER_NAME" ]]; then
    ROFI_MENU+="${WALLPAPER_NAME}\0icon\x1f${WALLPAPER_PATH}\n"
  else
    ROFI_MENU+="${WALLPAPER_NAME}\0icon\x1f${WALLPAPER_PATH}\n"
  fi
done <<<"$WALLPAPER_FILES"

# Show rofi menu with clean multi-column layout
SELECTED=$(echo -e "$ROFI_MENU" | rofi -dmenu -p "🎨 Select Wallpaper" -show-icons -markup-rows \
  -theme-str '
    window {
        width: 90%;
        height: 50%;
        x: 5%;
        y: 5%;
        padding: 20px;
    }
    
    mainbox {
        spacing: 20px;
        padding: 20px;
    }
    
    listview {
        lines: 8;
        columns: 4;
        fixed-height: false;
        dynamic: true;
        scrollbar: true;
        spacing: 10px;
        cycle: true;
    }
    
    element {
        orientation: vertical;
        spacing: 8px;
        padding: 12px;
        border-radius: 12px;
        cursor: pointer;
    }
    
    element-icon {
        size: 250px;
        horizontal-align: 0.5;
        vertical-align: 0.5;
        cursor: pointer;
        margin: 5px;
    }
    
    element-text {
        horizontal-align: 0.5;
        vertical-align: 0.5;
        cursor: pointer;
        padding: 5px;
    }
    
    
    prompt {
        padding: 8px 16px;
        border-radius: 8px;
    }
    
    entry {
        padding: 8px 12px;
        border-radius: 6px;
    }
    
    message {
        padding: 8px;
        border-radius: 8px;
    }')

if [[ -n "$SELECTED" ]]; then
  # Extract filename (remove emoji and spaces)
  SELECTED_NAME=$(echo "$SELECTED" | sed 's/^[^ ]* //')

  # Find the full path
  SELECTED_PATH=$(find "$WALLPAPER_DIR" -name "$SELECTED_NAME" | head -1)

  if [[ -n "$SELECTED_PATH" ]]; then
    echo "Setting wallpaper: $SELECTED_PATH"

    # Set wallpaper with hyprpaper
    pkill hyprpaper
    sleep 0.2
    hyprpaper &
    sleep 0.3
    hyprctl hyprpaper preload "$SELECTED_PATH"
    hyprctl hyprpaper wallpaper ",$SELECTED_PATH"

    # Update cache
    echo "$SELECTED_PATH" >"$CURRENT_WALLPAPER_FILE"

    notify-send "Wallpaper Changed" "$SELECTED_NAME" -i "$SELECTED_PATH"
  fi
fi
