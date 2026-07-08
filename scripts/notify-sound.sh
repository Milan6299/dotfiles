#!/usr/bin/env bash

SOUND="$HOME/.config/sounds/notify.wav"

# Check if mako DND mode is active
DND_ENABLED() {
  # makoctl mode outputs a list of active modes. We check if "dnd" is in that list.
  makoctl mode 2>/dev/null | grep -q "dnd"
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
