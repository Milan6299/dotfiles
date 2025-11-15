#!/usr/bin/zsh

# Detect touchpad device name
device=$(hyprctl devices | grep -i "touchpad" | sed 's/^[[:space:]]*//')
state_file="$HOME/.config/hypr/scripts/touchpad_disabled"

if [[ -z "$device" ]]; then
    notify-send "⚠️ No touchpad detected"
    exit 1
fi

if [[ -f "$state_file" ]]; then
    # Touchpad disabled → enable it
    hyprctl keyword "device[$device]:enabled" "true"
    rm -f "$state_file"
    notify-send "󰌌 Touchpad Enabled"
else
    # Touchpad enabled → disable it
    hyprctl keyword "device[$device]:enabled" "false"
    touch "$state_file"
    notify-send "󰍾 Touchpad Disabled"
fi
