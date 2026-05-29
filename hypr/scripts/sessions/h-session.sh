#!/bin/bash

#Launch browser and move to workspace 2
hyprctl dispatch workspace 2
firefox >/dev/null 2>&1 &

#Krita is assigned workspace 3 in hyprland conf
krita >/dev/null 2>&1 &
