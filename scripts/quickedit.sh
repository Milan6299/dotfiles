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

if [ -n "$TMUX" ]; then
  exec tmux new-window -c "$selected" "nvim"
else
  cd "$selected"
  exec nvim
fi
