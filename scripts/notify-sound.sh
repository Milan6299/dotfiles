#!/usr/bin/env bash

SOUND="$HOME/.config/sounds/notify.wav"

DND_ENABLED() {
  makoctl mode 2>/dev/null | grep -q '^dnd$'
}

while read -r line; do
  # optimized version replacing grep
  if [[ $line == *"member=Notify"* ]]; then
    DND_ENABLED && continue
    paplay "$SOUND" &
  fi
done < <(
  dbus-monitor "interface='org.freedesktop.Notifications',member='Notify'"
)
