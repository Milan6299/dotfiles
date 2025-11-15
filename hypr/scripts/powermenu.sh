#!/bin/zsh

# Simple multi-line string instead of array
choice=$(echo "  Shutdown
  Reboot
  Lock
  Logout
󰤄  Suspend" | rofi -dmenu -p "Power Menu: " -lines 5 -i -theme-str '
    window {
        width: 20%;
    }
    listview {
        lines: 5;
        fixed-height: true;
    }
')

# Execute chosen action
case "$choice" in
    "  Shutdown") systemctl poweroff ;;
    "  Reboot") systemctl reboot ;;
    "  Lock") hyprlock ;;
    "  Logout") hyprctl dispatch exit ;;
    "󰤄  Suspend")
        hyprlock &
        sleep 0.5
        systemctl suspend
        ;;
    *) exit 0 ;;
esac
