#!/usr/bin/env bash

docdir="/usr/share/doc"
# For future additions
# personaldocs="~/Documents"

seldir=$(fd --type d . "$docdir" --max-depth=1 | fzf --prompt="-> ") || exit

read -rp "query: " query

selected=$(
  rg -l "$query" "$seldir" |
    fzf --preview '
          case {} in
              *.html|*.htm)
                  w3m -dump {} | rg --color=always -n -C2 "'"$query"'"
                  ;;
              *)
                  rg --color=always -n -C2 "'"$query"'" {} ||
                  bat --style=plain --color=always {}
                  ;;
          esac
          ' \
      --bind='ctrl-n:preview-down' \
      --bind='ctrl-p:preview-up' \
      --prompt="-> "
) || exit

case "$selected" in
*.html | *.htm)
  exec w3m "$selected"
  ;;
*)
  exec nvim "$selected"
  ;;
esac
