#!/usr/bin/env bash
set -euo pipefail

SCRIPT_PATH="${BASH_SOURCE[0]}"

option() {
  local name="$1"
  local fallback="$2"
  local value
  value="$(tmux show-option -gqv "$name" 2>/dev/null || true)"
  if [ -n "$value" ]; then
    printf '%s' "$value"
  else
    printf '%s' "$fallback"
  fi
}

scope() {
  if [ -n "${AGENTS_SESSIONS_SCOPE:-}" ]; then
    printf '%s' "$AGENTS_SESSIONS_SCOPE"
  else
    option '@agents_sessions_scope' 'all'
  fi
}

agent_words() {
  option '@agents_sessions_agents' 'claude codex opencode pi'
}

current_session_id() {
  tmux display-message -p '#{session_id}' 2>/dev/null || true
}

cache_dir() {
  printf '%s/tmux-agent-sessions-%s' "${TMPDIR:-/tmp}" "$(id -u)"
}

cache_key() {
  local socket
  socket="$(tmux display-message -p '#{socket_path}' 2>/dev/null || printf 'default')"
  printf '%s' "$socket" | cksum | awk '{print $1}'
}

cache_path() {
  local requested_scope session_id safe_session_id
  requested_scope="$(scope)"
  session_id="$(current_session_id)"
  safe_session_id="$(printf '%s' "$session_id" | tr -c '[:alnum:]_-' '_')"
  printf '%s/%s_%s_%s.tsv' "$(cache_dir)" "$(cache_key)" "$safe_session_id" "$requested_scope"
}

cache_list() {
  local path
  path="$(cache_path)"
  if [ -s "$path" ]; then
    cat "$path"
  fi
}

cache_refresh() {
  local dir path tmp
  dir="$(cache_dir)"
  path="$(cache_path)"
  mkdir -p "$dir"
  tmp="$(mktemp "$dir/.agent-sessions.XXXXXX")"
  rows > "$tmp"
  mv "$tmp" "$path"
}

cache_refresh_async() {
  ("$SCRIPT_PATH" cache-refresh >/dev/null 2>&1 &)
}

state_loop_pid_path() {
  printf '%s/state-loop.pid' "$(cache_dir)"
}

state_loop_start() {
  local dir pid_path pid
  dir="$(cache_dir)"
  pid_path="$(state_loop_pid_path)"
  mkdir -p "$dir"

  if [ -s "$pid_path" ]; then
    pid="$(cat "$pid_path" 2>/dev/null || true)"
    if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
      return 0
    fi
  fi

  ("$SCRIPT_PATH" state-loop >/dev/null 2>&1 & echo $! > "$pid_path")
}

state_loop() {
  while tmux display-message -p '#{pid}' >/dev/null 2>&1; do
    "$SCRIPT_PATH" pane-state-refresh >/dev/null 2>&1 || true
    sleep 1
  done
}

lower() {
  tr '[:upper:]' '[:lower:]'
}

agent_for() {
  local original haystack
  original="$1"
  haystack="$(printf '%s' "$original" | lower)"

  if printf '%s' "$original" | grep -Fq 'π'; then
    printf 'pi'
    return 0
  fi

  if printf '%s' "$haystack" | grep -Eq '(^|[^[:alnum:]_-])(pi-coding-agent|pi coding agent)([^[:alnum:]_-]|$)'; then
    printf 'pi'
    return 0
  fi

  if printf '%s' "$haystack" | grep -Eq '(^|[^[:alnum:]_-])opencode([^[:alnum:]_-]|$)'; then
    printf 'opencode'
    return 0
  fi

  if printf '%s' "$haystack" | grep -Eq '(^|[^[:alnum:]_-])(claude|claude-code|claude code)([^[:alnum:]_-]|$)'; then
    printf 'claude'
    return 0
  fi

  if printf '%s' "$original" | grep -Eq '(^|[[:space:]])[0-9]+\.[0-9]+\.[0-9]+([[:space:]]|$)'; then
    printf 'claude'
    return 0
  fi

  if printf '%s' "$haystack" | grep -Eq '(^|[^[:alnum:]_-])(codex|openai-codex)([^[:alnum:]_-]|$)'; then
    printf 'codex'
    return 0
  fi

  local agent
  for agent in $(agent_words); do
    local lowered_agent
    lowered_agent="$(printf '%s' "$agent" | lower)"
    if printf '%s' "$haystack" | grep -Eq '(^|[^[:alnum:]_-])'"$lowered_agent"'([^[:alnum:]_-]|$)'; then
      printf '%s' "$agent"
      return 0
    fi
  done
  return 1
}

quick_status_for() {
  local pane_dead="$1"
  local pane_title="$2"
  local lowered_title

  if [ "$pane_dead" = "1" ]; then
    printf 'dead'
    return 0
  fi

  lowered_title="$(printf '%s' "$pane_title" | lower)"

  if printf '%s' "$lowered_title" | grep -Eiq 'permission|approval|approve|allow|deny|confirm|ask.?user|askusertool|waiting|select an option|accept|reject'; then
    printf 'waiting'
    return 0
  fi

  if printf '%s' "$pane_title" | grep -Eq '^[[:space:]]*[✳✻●•*⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏⠐⠂⠄⡀⢀⣀⣄⣤⣦⣶⣷⣿◐◓◑◒]'; then
    printf 'running'
    return 0
  fi

  if printf '%s' "$lowered_title" | grep -Eiq 'greeting|ready|claude code'; then
    printf 'idle'
    return 0
  fi

  printf 'idle'
}

status_for() {
  local pane_id="$1"
  local pane_dead="$2"
  local pane_title="$3"

  if [ "$pane_dead" = "1" ]; then
    printf 'dead'
    return 0
  fi

  if [ "${AGENTS_SESSIONS_FAST:-}" = "1" ]; then
    quick_status_for "$pane_dead" "$pane_title"
    return 0
  fi

  local text recent
  text="$(tmux capture-pane -pJ -S -50 -t "$pane_id" 2>/dev/null || true)"
  recent="$(printf '%s' "$text" | tail -n 30)"

  if printf '%s' "$recent" | tail -n 10 | grep -Eiq '(^|[[:space:]])(>|›|❯)[[:space:]]*$|type your message|send a message|what can i help|ready|auto mode on'; then
    printf 'idle'
    return 0
  fi

  if printf '%s' "$recent" | tail -n 20 | grep -Eiq 'permission required|needs approval|approval required|approve command|allow command|deny command|continue\?|proceed\?|yes/no|\(y/n\)|\[y/n\]|\(Y/n\)|\[Y/n\]|ask.?user|askusertool|needs? (your )?input|waiting for (your )?input|press enter|select an option|do you want|would you like|run this command|execute this command|trust this command|accept changes|reject changes|1\. yes|2\. no'; then
    printf 'waiting'
    return 0
  fi

  if printf '%s' "$recent" | tail -n 25 | grep -Eiq '^[[:space:]]*(thinking|working|processing|executing|searching|reading|writing|editing)(\.\.\.|…)|^[[:space:]]*(⠋|⠙|⠹|⠸|⠼|⠴|⠦|⠧|⠇|⠏|✻|●|◐|◓|◑|◒)[[:space:]]|calling tool|tool call|esc to interrupt|ctrl-c|interrupt'; then
    printf 'running'
    return 0
  fi

  quick_status_for "$pane_dead" "$pane_title"
}

trim() {
  local max="$1"
  local value="$2"
  if [ "${#value}" -le "$max" ]; then
    printf '%s' "$value"
  else
    printf '%s…' "${value:0:$((max - 1))}"
  fi
}

display_path_for() {
  local path="$1"
  printf '%s' "$path" | sed "s|^$HOME|~|"
}

title_for() {
  local agent="$1"
  local pane_title="$2"
  local window_name="$3"
  local pane_path="$4"
  local title="$pane_title"

  if [ "$agent" = "pi" ]; then
    title="$(printf '%s' "$title" | sed -E 's/^[[:space:]]*π[[:space:]]*-[[:space:]]*//')"
  else
    title="$(printf '%s' "$title" | sed -E 's/^[[:space:]]*[✳✻●•*⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏⠐⠂⠄⡀⢀⣀⣄⣤⣦⣶⣷⣿◐◓◑◒-]+[[:space:]]*//')"
  fi

  title="$(printf '%s' "$title" | sed -E 's/^[[:space:]]*OC[[:space:]]*[|][[:space:]]*//; s/[[:space:]]+-[[:space:]]+[^[:space:]]+$//; s/^[[:space:]]+//; s/[[:space:]]+$//')"

  if [ -z "$title" ] || printf '%s' "$title" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$|^[^[:space:]]+\.local$'; then
    title="$window_name"
  fi

  if [ "$title" = "node" ] || printf '%s' "$title" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$'; then
    title="$(basename "$pane_path")"
  fi

  printf '%s' "$title"
}

pane_state_refresh() {
  tmux list-panes -a -F '#{window_name}	#{pane_id}	#{pane_current_command}	#{pane_title}	#{pane_current_path}	#{pane_dead}	#{@pane_status}' |
  while IFS=$'\t' read -r window_name pane_id pane_command pane_title pane_path pane_dead hook_status; do
    local agent haystack state title
    haystack="$pane_command $window_name $pane_title"
    if ! agent="$(agent_for "$haystack")"; then
      tmux set-option -p -q -t "$pane_id" @agents_state '' 2>/dev/null || true
      tmux set-option -p -q -t "$pane_id" @agents_title '' 2>/dev/null || true
      continue
    fi

    if [ -n "$hook_status" ]; then
      state="$hook_status"
    else
      state="$(status_for "$pane_id" "$pane_dead" "$pane_title")"
    fi

    title="$(title_for "$agent" "$pane_title" "$window_name" "$pane_path")"
    tmux set-option -p -q -t "$pane_id" @agents_state "$state" 2>/dev/null || true
    tmux set-option -p -q -t "$pane_id" @agents_title "$title" 2>/dev/null || true
  done
}

emit_rows() {
  local filter="$1"
  local current_session_id="$2"

  while IFS=$'\t' read -r session_id session_name window_id window_index window_name pane_id pane_index pane_command pane_title pane_path pane_dead; do
    if [ -z "${session_id:-}" ]; then
      continue
    fi

    case "$filter" in
      current)
        [ "$session_id" = "$current_session_id" ] || continue
        ;;
      other)
        [ "$session_id" != "$current_session_id" ] || continue
        ;;
    esac

    local agent haystack status marker display target short_session short_title short_path session_title state display_path
    haystack="$pane_command $window_name $pane_title"
    if ! agent="$(agent_for "$haystack")"; then
      continue
    fi

    status="$(status_for "$pane_id" "$pane_dead" "$pane_title")"
    state="$status"
    if [ "$session_id" = "$current_session_id" ]; then
      marker='*'
    else
      marker=' '
    fi

    session_title="$(title_for "$agent" "$pane_title" "$window_name" "$pane_path")"
    display_path="$(display_path_for "$pane_path")"
    short_session="$(trim 16 "$session_name")"
    short_title="$(trim 32 "$session_title")"
    short_path="$(trim 40 "$display_path")"
    display="$(printf '%-1s %-8s %-32s %-16s %-8s %s' "$marker" "$state" "$short_title" "$short_session" "$agent" "$short_path")"
    target="${pane_id#%}"
    printf '%s\t%s\n' "$display" "$target"
  done
}

rows() {
  local requested_scope current_session_id pane_rows
  requested_scope="$(scope)"
  current_session_id="$(current_session_id)"
  pane_rows="$(tmux list-panes -a -F '#{session_id}	#{session_name}	#{window_id}	#{window_index}	#{window_name}	#{pane_id}	#{pane_index}	#{pane_current_command}	#{pane_title}	#{pane_current_path}	#{pane_dead}')"

  if [ "$requested_scope" = "all" ]; then
    printf '%s\n' "$pane_rows" | emit_rows current "$current_session_id"
    printf '%s\n' "$pane_rows" | emit_rows other "$current_session_id"
  else
    printf '%s\n' "$pane_rows" | emit_rows current "$current_session_id"
  fi
}

print_table() {
  printf '%-1s %-8s %-32s %-16s %-8s %s\n' '' 'STATE' 'TITLE' 'SESH/PROJECT' 'AGENT' 'PATH'
  rows | cut -f1
}

target_parts() {
  local target="$1"
  TARGET_SESSION_ID=''
  TARGET_WINDOW_ID=''
  TARGET_PANE_ID=''

  if printf '%s' "$target" | grep -q '|'; then
    IFS='|' read -r TARGET_SESSION_ID TARGET_WINDOW_ID TARGET_PANE_ID <<EOF_TARGET
$target
EOF_TARGET
    return 0
  fi

  case "$target" in
    %*) TARGET_PANE_ID="$target" ;;
    *) TARGET_PANE_ID="%$target" ;;
  esac

  local pane_info
  pane_info="$(tmux list-panes -a -F '#{pane_id}	#{session_id}	#{window_id}' 2>/dev/null | awk -F '\t' -v pane="$TARGET_PANE_ID" '$1 == pane { print $2 "\t" $3; exit }')"
  if [ -n "$pane_info" ]; then
    IFS=$'\t' read -r TARGET_SESSION_ID TARGET_WINDOW_ID <<EOF_INFO
$pane_info
EOF_INFO
  fi
}

attach_target() {
  local target="$1"
  target_parts "$target"

  if [ -z "${TARGET_PANE_ID:-}" ]; then
    return 1
  fi

  tmux switch-client -t "$TARGET_SESSION_ID" 2>/dev/null || true
  tmux select-window -t "$TARGET_WINDOW_ID" 2>/dev/null || true
  tmux select-pane -t "$TARGET_PANE_ID" 2>/dev/null || true
}

preview_target() {
  local target="$1"
  target_parts "$target"

  if [ -z "${TARGET_PANE_ID:-}" ] || ! tmux list-panes -a -F '#{pane_id}' | grep -qFx "$TARGET_PANE_ID"; then
    printf 'Pane not found\n'
    return 0
  fi

  tmux display-message -p -t "$TARGET_PANE_ID" '#{session_name}  #{window_index}:#{window_name}.#{pane_index}  #{pane_current_path}' 2>/dev/null || true
  printf '\n'
  tmux capture-pane -pJ -S -120 -t "$TARGET_PANE_ID" 2>/dev/null || true
}

popup() {
  if ! command -v fzf >/dev/null 2>&1; then
    while true; do
      clear
      printf 'tmux agent sessions\n\n'
      print_table
      printf '\nInstall fzf for interactive selection. Press Ctrl-C to close.\n'
      sleep 2
    done
  fi

  local list_cmd current_list_cmd all_list_cmd selection target
  "$SCRIPT_PATH" cache-refresh-async
  list_cmd="AGENTS_SESSIONS_SCOPE=$(scope) '$SCRIPT_PATH' cache-refresh >/dev/null; AGENTS_SESSIONS_SCOPE=$(scope) '$SCRIPT_PATH' cache-list"
  current_list_cmd="AGENTS_SESSIONS_SCOPE=current '$SCRIPT_PATH' cache-refresh >/dev/null; AGENTS_SESSIONS_SCOPE=current '$SCRIPT_PATH' cache-list"
  all_list_cmd="AGENTS_SESSIONS_SCOPE=all '$SCRIPT_PATH' cache-refresh >/dev/null; AGENTS_SESSIONS_SCOPE=all '$SCRIPT_PATH' cache-list"
  selection="$("$SCRIPT_PATH" cache-list | fzf \
    --ansi \
    --border=none \
    --delimiter=$'\t' \
    --with-nth=1 \
    --header='Enter: focus pane | Ctrl-R: refresh | Ctrl-S: current session | Ctrl-A: all sessions | Esc: close' \
    --preview="$SCRIPT_PATH preview {2}" \
    --preview-window='right,45%,border-left,nowrap' \
    --bind="ctrl-r:reload-sync($list_cmd)" \
    --bind="ctrl-s:reload-sync($current_list_cmd)" \
    --bind="ctrl-a:reload-sync($all_list_cmd)" \
    --no-sort \
    --layout=reverse \
    --prompt='agents > ' || true)"

  if [ -z "$selection" ]; then
    return 0
  fi

  target="${selection#*$'\t'}"
  attach_target "$target"
}

case "${1:-popup}" in
  rows|fzf-list)
    rows
    ;;
  cache-list)
    cache_list
    ;;
  cache-refresh)
    cache_refresh
    ;;
  cache-refresh-async)
    cache_refresh_async
    ;;
  state-loop-start)
    state_loop_start
    ;;
  state-loop)
    state_loop
    ;;
  pane-state-refresh)
    pane_state_refresh
    ;;
  list)
    print_table
    ;;
  popup)
    popup
    ;;
  attach)
    attach_target "${2:-}"
    ;;
  preview)
    preview_target "${2:-}"
    ;;
  *)
    printf 'usage: %s [popup|list|rows|fzf-list|attach target]\n' "$0" >&2
    exit 2
    ;;
esac
