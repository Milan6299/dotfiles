#!/bin/bash

# open browser on workspace 2 (force new window)
hyprctl dispatch exec "[workspace 2] brave --new-window"

# open terminal on workspace 1
hyprctl dispatch exec "[workspace 1] kitty tmux new-session -A -s work"

# small delay so browser spawns properly
sleep 0.8

# go back to workspace 1
hyprctl dispatch workspace 1
