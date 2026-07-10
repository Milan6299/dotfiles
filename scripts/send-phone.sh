#!/usr/bin/env bash

ipuser="tailscale"
pcpath="$1"
phpath="${2:-~/storage/laptop}"

if scp -r "$pcpath" "$ipuser:$phpath"; then
  notify-send "Transfer Successful!" "Copied to $ipuser's $phpath"
else
  notify-send -u critical "Transfer Failed!"
fi
