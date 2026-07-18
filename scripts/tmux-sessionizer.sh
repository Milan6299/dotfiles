#!/usr/bin/env bash
set -euo pipefail

WORKSPACE_DIR="${TMUX_WORKSPACES_DIR:-$HOME/.config/tmux-workspaces}"
CACHE_FILE="$HOME/.cache/tmux-sessionizer/sessions.db"

#####################################
# tmux helpers
#####################################

tmux_has_session() {
  tmux has-session -t "$1" 2>/dev/null
}

tmux_switch() {
  local target="$1"

  if [[ -n "${TMUX:-}" ]]; then
    exec tmux switch-client -t "$target"
  else
    exec tmux attach-session -t "$target"
  fi
}

#####################################
# cache
#####################################

get_sessions() {
  [[ -f "$CACHE_FILE" ]] && cat "$CACHE_FILE" || true
}

get_session_by_index() {
  get_sessions | sed -n "${1}p" | cut -d'|' -f2
}

#####################################
# workspace discovery
#####################################

list_workspaces() {
  find "$WORKSPACE_DIR" \
    -maxdepth 1 \
    -type f \
    -name "*.sh" \
    2>/dev/null |
    while read -r f; do
      basename "$f" .sh
    done | sort
}

#####################################
# UI
#####################################
hard_coded_list() {
  local entries=(
    "1 basic"
    "2 work"
    "3 study"
    "4 music"
    "5 phone"
  )

  printf '%s\n' "${entries[@]}"
}

build_list() {
  # running sessions from cache
  while IFS='|' read -r idx name; do
    [[ -n "$name" ]] || continue
    echo "$idx $name"
  done <"$CACHE_FILE" 2>/dev/null || true

  # workspaces not currently running
  while read -r ws; do
    [[ -z "$ws" ]] && continue

    if [[ -f "$CACHE_FILE" ]] &&
      grep -q "|$ws$" "$CACHE_FILE"; then
      continue
    fi

    echo "  $ws"
  done < <(list_workspaces)
}

prompt() {

  hard_coded_list | fzf \
    --border \
    --prompt="tmux > " \
    --bind 'one:accept'
  # build_list | fzf \
  #   --border \
  #   --prompt="tmux > " \
  #   --bind 'one:accept'
}

#####################################
# parsing
#####################################

parse_name() {
  local line="$1"

  if [[ "$line" =~ ^[0-9]+[[:space:]]+ ]]; then
    printf '%s\n' "${line#* }"
  else
    printf '%s\n' "${line#"  "}"
  fi
}

#####################################
# workspace loading
#####################################

load_workspace() {
  local name="$1"
  local file="$WORKSPACE_DIR/$name.sh"

  [[ -f "$file" ]] || {
    echo "Workspace not found: $file" >&2
    exit 1
  }

  unset SESSION ROOT

  source "$file"

  [[ -n "${SESSION:-}" ]] || {
    echo "Missing SESSION in $file" >&2
    exit 1
  }

  [[ -n "${ROOT:-}" ]] || {
    echo "Missing ROOT in $file" >&2
    exit 1
  }
}

call_if_exists() {
  local fn="$1"
  shift

  if declare -f "$fn" >/dev/null; then
    "$fn" "$@"
  fi
}

start_workspace() {
  call_if_exists start
}

#####################################
# resolve
#####################################

resolve() {
  local input="$1"

  if [[ "$input" =~ ^[0-9]+$ ]]; then
    input="$(get_session_by_index "$input")"
  fi

  echo "$input"
}

#####################################
# dispatch
#####################################

dispatch() {
  local name="$1"

  ###################################
  # existing session
  ###################################
  if tmux_has_session "$name"; then
    tmux_switch "$name"
  fi

  ###################################
  # workspace
  ###################################
  if [[ -f "$WORKSPACE_DIR/$name.sh" ]]; then
    load_workspace "$name"

    if ! tmux_has_session "$SESSION"; then
      start_workspace
    fi

    tmux_switch "$SESSION"
  fi

  ###################################
  # plain session fallback
  ###################################
  if tmux_has_session "$name"; then
    tmux_switch "$name"
  fi

  exec tmux new-session -A -s "$name"
}

#####################################
# entry
#####################################

main() {
  local input="${1:-}"

  if [[ -z "$input" ]]; then
    input="$(prompt)"
    [[ -z "$input" ]] && exit 0
  fi

  local name
  name="$(parse_name "$input")"
  name="$(resolve "$name")"

  dispatch "$name"
}

main "$@"
