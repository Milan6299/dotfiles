# ~/.config/tmux-workspaces/study.sh

SESSION="music"
ROOT="$HOME"

start() {
  tmux new-session -d -s "$SESSION" -c "$ROOT" -n "music"
  # tmux send-keys -t "$SESSION" "ytm" C-m
}
