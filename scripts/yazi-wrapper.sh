#!/usr/bin/env sh
set -e

multiple="$1"
directory="$2"
save="$3"
path="$4"
out="$5"

# CHANGE THIS to your preferred terminal emulator if not using kitty
# Make sure to include a distinct class name so Hyprland can target it
termcmd="foot --app-id=file_chooser -e"
cmd="yazi"

if [ "$save" = "1" ]; then
  set -- --chooser-file="$out" "$path"
elif [ "$directory" = "1" ]; then
  set -- --chooser-file="$out" "$path"
elif [ "$multiple" = "1" ]; then
  set -- --chooser-file="$out" "$path"
else
  set -- --chooser-file="$out" "$path"
fi

$termcmd $cmd "$@"
