#!/usr/bin/env bash

tmuxcht() {
  if [[ -n "$TMUX" ]]; then
    tmux new-window bash -c "curl cheat.sh/$1$2 | less -R"
  else
    bash -c "curl cheat.sh/$1$2 | less -R"
  fi
}

handleedge() {
  if [[ -n "$TMUX" ]]; then
    exec tmux new-window bash -c "$1 $2 | less -R"
  else
    bash -c "$1 $2 | less -R"
  fi
}

manual=$(echo "tldr man" | tr ' ' '\n')
lang=$(echo "lua python bash cpp c sql" | tr ' ' '\n')
utils=$(echo "xargs awk grep rg sed gpg" | tr ' ' '\n')

result=$(
  printf "%s\n%s\n%s" "$lang" "$utils" "$manual" |
    fzf --print-query
)

selected=$(tail -n1 <<<"$result")

if [[ -z "$selected" ]]; then
  exit 1
fi

notinlist=1
if ! echo "$manual $lang $utils" | grep -qsw "$selected"; then
  notinlist=0
  printf "selected: %s\n query: /functions | /:learn | /async+function | ~query(for utils)\n" "$selected"
fi

read -p "query: " qu

if ((notinlist == 0)); then
  tmuxcht "$selected" "$qu"
elif [[ "$selected" == "man" || "$selected" == "tldr" ]]; then
  handleedge "$selected" "$qu"
elif echo "$lang" | grep -qsw "$selected"; then
  query=$(echo "/$qu" | tr ' ' '+')
  tmuxcht "$selected" "$query"
else
  query=$(echo "~$qu" | tr ' ' '+')
  tmuxcht "$selected" "$query"
fi
