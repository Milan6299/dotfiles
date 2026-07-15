#!/usr/bin/env bash

/usr/bin/ssh "$@"
code=$?

if ((code != 0)); then
  notify-send -u critical "$1" "SSH connection died! Exit code: $code"
else
  notify-send "SSH connection terminated"
fi

exit $code
