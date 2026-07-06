# ~/.config/tmux-workspaces/work.sh

SESSION="work"
ROOT="$HOME/Projects/FullStack/cflow/"

start() {
  tmux new-session -d -s "$SESSION" -c "$ROOT" -n "editor"

  # frontend
  # tmux new-window -t "$SESSION" -n "frontend" -c "$ROOT/frontend"
  # tmux send-keys -t "$SESSION:frontend" "nvim" C-m

  # backend
  tmux new-window -t "$SESSION" -n "backend" -c "$ROOT/api"
  tmux send-keys -t "$SESSION:backend" "ls" C-m

  # logs
  tmux new-window -t "$SESSION" -n "logs" -c "$ROOT"
  tmux send-keys -t "$SESSION:logs" "btop" C-m

  # selects active window on start
  tmux select-window -t "$SESSION:editor"
}
