SESSION="basic"
ROOT="$(pwd)"

start() {
  tmux new-session -d -s "$SESSION" -c "$ROOT"
}
