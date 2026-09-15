# ~/.config/tmux-workspaces/work.sh

SESSION="work"
ROOT="$HOME/projects"

start() {
  tmux new-session \
    -d \
    -s "$SESSION" \
    -c "$ROOT" \
    -n "editor"

  sleep 0.1

  tmux send-keys \
    -t "$SESSION:editor" \
    "cd \"\$(fd --type d --max-depth=2 | fzf --prompt='->')\" && nvim ." C-m

  tmux select-window -t "$SESSION:editor"
}
