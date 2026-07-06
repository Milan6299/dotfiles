# ~/.config/tmux-workspaces/study.sh

SESSION="music"
ROOT="$HOME"

start() {
  tmux new-session -d -s "$SESSION" -c "$ROOT"
  # tmux send-keys -t "$SESSION" "ytm" C-m
}
