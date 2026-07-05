#!/usr/bin/env bash

notifymsg() {
  if (($1 == 0)); then
    notify-send "Download Successful!" "Located at - $2"
    exit 0
  else
    notify-send -u critical "Download Failed!" "Something went wrong!"
    exit 1
  fi
}

if [[ "$1" == "audio" ]]; then
  pathtodwn="${3:-$PWD}"

  notify-send "Audio Download Started!" "Downloading in background! URL - $2"

  /usr/bin/yt-dlp -P "$pathtodwn" "$2" -x --audio-format mp3

  code=$?
  notifymsg "$code" "$pathtodwn"
  exit
fi

location="${2:-$PWD}"

notify-send "Video Download Started!" "Downloading in background! URL - $1"

/usr/bin/yt-dlp -P "$location" "$1" -f "bestvideo[height<=1080][ext=mp4]+(bestaudio[ext=m4a]/bestaudio)/best[height<=1080][ext=mp4]/best" --merge-output-format mp4

code=$?
notifymsg "$code" "$location"
exit
