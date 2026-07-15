# ~/.config/tmux-workspaces/study.sh

SESSION="study"
ROOT="$HOME/personal/Study/SQL"

start() {
  tmux new-session -d -s "$SESSION" -c "$ROOT" -n "editor"

  tmux send-keys -t "$SESSION:editor" "nvim $ROOT/practice/sess +'DBUI'" C-m

  tmux new-window -t "$SESSION" -n "postgres" -c "$ROOT"

  tmux send-keys -t "$SESSION:postgres" \
    "psql -U modisarkar -d MyDatabase" C-m

  tmux new-window -t "$SESSION" -n "materials" -c "$ROOT"

  tmux new-window -t "$SESSION" -n "note" -c "$ROOT"

  tmux send-keys -t "$SESSION:note" "systemctl --user start opentabletdriver.service && rnote; systemctl --user stop opentabletdriver.service" C-m

  tmux select-window -t "$SESSION:editor"

  swaymsg "workspace 2; exec mpv '$ROOT/sql-full-course.mp4'"
  # swaymsg mpv "$SESSION/sql-full-course.mp4", workspace 4

  # firefox "https://www.youtube.com/watch?v=SSKVgrwhzus" & disown
}
