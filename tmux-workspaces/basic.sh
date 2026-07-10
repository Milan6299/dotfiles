SESSION="basic"
ROOT="$HOME"

start() {
  tmux new-session -d -s "$SESSION" -c "$ROOT"
}
