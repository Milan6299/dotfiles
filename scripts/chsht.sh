#!/usr/bin/env bash

tmuxcht() {
  tmux new-window bash -c "curl cheat.sh/$1$2 | less -R"
}

manual=$(echo "tldr man" | tr ' ' '\n')
lang=$(echo "lua python tmux bash cpp c typescript javascript sql" | tr ' ' '\n')
utils=$(echo "xargs awk grep rg ripgrep" | tr ' ' '\n')

selected=$(printf "%s\n%s\n%s" "$lang" "$utils" "$manual" | fzf)

if [[ -z "$selected" ]]; then
  exit 1
fi

read -p "query: " qu

if [[ "$selected" == "tldr" ]]; then
  tmux new-window bash -c "$selected $qu | less "
elif [[ "$selected" == "man" ]]; then
  tmux new-window bash -c "$selected $qu"
elif echo "$lang" | grep -qsw "$selected"; then
  query=$(echo "/$qu" | tr ' ' '+')
  tmuxcht $selected $query
else
  echo "$utils" | grep -qsw "$selected"
  query=$(echo "~$qu" | tr ' ' '+')
  tmuxcht $selected $query
fi
