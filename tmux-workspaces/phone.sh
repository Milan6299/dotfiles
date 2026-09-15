# ~/.config/tmux-workspaces/phone.sh

SESSION="phone"
ROOT="$HOME"

start() {
  tmux new-session -d -s "$SESSION" -c "$ROOT"

  sleep 0.1

  tmux send-keys -t "$SESSION" "ssh tailscale" C-m
}
