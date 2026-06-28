#!/usr/bin/env bash

#run 3 commands and pipe output to fzf { cmd 1 2 3}
selected=$(
  {
    fd . "$HOME/.config" --min-depth 1 --max-depth 1 --type d
    fd . "$HOME/Projects" --min-depth 1 --max-depth 1 --type d
    echo "$HOME/Downloads"
  } | fzf --prompt="Jump → "
)

[ -z "$selected" ] && exit

# exec foot --app-id quickedit --working-directory="$selected" -e nvim
# tmux new-window -c "$selected" "nvim"
# code=$?
#
# if [ "$code" -ne 0 ]; then
#   foot --app-id quickedit --working-directory="$selected" -e nvim

if [ -n "$TMUX" ]; then
  exec tmux new-window -c "$selected" "nvim"
else
  # exec foot --app-id quickedit --working-directory="$selected" -e nvim
  cd "$selected"
  exec nvim
fi
