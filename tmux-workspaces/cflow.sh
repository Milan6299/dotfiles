# ~/.config/tmux-workspaces/cflow.sh

SESSION="cflow"
ROOT="$HOME/projects/cflow"
BACKEND="$HOME/projects/cflow-web/backend"

start() {
  tmux new-session -d -s "$SESSION" -c "$ROOT" -n "cli"
  tmux new-window -t "$SESSION" -c "$BACKEND" -n "backend"
  tmux new-window -t "$SESSION" -c "$BACKEND" -n "server"

  sleep 0.1

  tmux send-keys -t "$SESSION:cli" "nvim ." C-m
  tmux send-keys -t "$SESSION:backend" "nvim ." C-m
  tmux send-keys -t "$SESSION:server" \
    "uv run uvicorn cflow_web.api.main:app --reload" C-m

  tmux select-window -t "$SESSION:cli"
}
