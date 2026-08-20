# ~/.config/tmux-workspaces/work.sh

SESSION="work"
ROOT="$HOME/projects/cflow/"
BACKEND="$ROOT/backend"

start() {
  # tmux new-session -d -s "$SESSION" -c "$ROOT" -n "editor"
  tmux new-session -d -s "$SESSION" -c "$BACKEND" -n "editor"
  tmux send-keys -t "$SESSION:editor" "nvim ." C-m

  # frontend
  # tmux new-window -t "$SESSION" -n "frontend" -c "$ROOT/frontend"
  # tmux send-keys -t "$SESSION:frontend" "nvim" C-m

  # server
  tmux new-window -t "$SESSION" -n "server" -c "$BACKEND"
  tmux send-keys -t "$SESSION:server" \
    "uv run uvicorn cflow.api.main:app --reload" C-m

  # backend
  tmux new-window -t "$SESSION" -n "backend" -c "$BACKEND"
  tmux send-keys -t "$SESSION:backend" "ls" C-m

  # logs
  # tmux new-window -t "$SESSION" -n "logs" -c "$ROOT"
  # tmux send-keys -t "$SESSION:logs" "btop" C-m

  # selects active window on start
  tmux select-window -t "$SESSION:editor"
}
