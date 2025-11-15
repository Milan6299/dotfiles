#!/bin/bash

# Battery status monitoring with notifications

while true; do
  battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
  battery_status=$(cat /sys/class/power_supply/BAT0/status)

  if [[ $battery_status == "Discharging" ]]; then
    if [[ $battery_level -le 20 ]]; then
      notify-send -u critical "Battery Critical" "Battery level is ${battery_level}% - Plug in immediately!"
      # You can also add sound notification
      # paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga
    elif [[ $battery_level -le 30 ]]; then
      notify-send -u normal "Battery Low" "Battery level is ${battery_level}% - Consider plugging in"
    fi
  fi

  sleep 300 # Check every 5 minutes
done
