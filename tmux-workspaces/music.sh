# ~/.config/tmux-workspaces/study.sh

SESSION="music"
ROOT="$HOME"

start() {
  tmux new-session -d -s "$SESSION" -c "$ROOT" -n "music"
}
