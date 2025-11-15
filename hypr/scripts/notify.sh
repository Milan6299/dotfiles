#!/usr/bin/env bash

# Path to sound file
SOUND="$HOME/.config/sounds/notify.wav"

# Check if swaync DND is on — if available
DND_ENABLED() {
  swaync-client -D 2>/dev/null | grep -q "true"
}

# Listen to DBus notifications
dbus-monitor "interface='org.freedesktop.Notifications',member='Notify'" |
  while read -r line; do
    # Only play sound on actual Notify call
    if echo "$line" | grep -q "member=Notify"; then

      # Skip if DND enabled
      if DND_ENABLED; then
        continue
      fi

      # Play sound
      paplay "$SOUND" &
    fi
  done
