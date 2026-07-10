#!/usr/bin/env bash

if [ "$#" -eq 0 ]; then
  echo "No url specified!"
  exit 1
fi

notify-send "Playing Audio..." "$1"

cat <<'EOF'
=========================================================
                    PODCAST CONTROLS
=========================================================
 [Space]      : Play / Pause  | [ / ] : Speed -/+ 10%
 [Left/Right] : Seek -/+ 5s   | { / } : Half / Double
 [Up/Down]    : Seek -/+ 1m   | Bksp  : Normal Spd (1x)
 9 / 0        : Vol Down/Up   | m / q : Mute / Quit
=========================================================
EOF

if echo "$1" | grep -q 'playlist'; then
  playlist="inf"
fi

# if [ "$#" -eq 1 ]; then
mpv --no-video --no-resume-playback --loop-playlist="${playlist:-no}" --demuxer-max-bytes=50M --input-ipc-server=/tmp/mpv-socket "$1"
# else
#   mpv --no-video --no-resume-playback --loop-playlist="${playlist:-no}"  --demuxer-max-bytes=50M --input-ipc-server=/tmp/mpv-socket "$1"
# fi

code=$?

if [ "$code" -eq 0 ]; then
  notify-send "Audio Terminated Successfully"
else
  notify-send -u critical "Abnormal Termination" "Audio terminated with exit code - $code"
fi
