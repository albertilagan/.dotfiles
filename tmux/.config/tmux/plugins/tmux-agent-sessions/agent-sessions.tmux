#!/usr/bin/env bash
set -euo pipefail

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT="$CURRENT_DIR/scripts/agent-sessions.sh"

key="$(tmux show-option -gqv '@agents_sessions_key')"
scope="$(tmux show-option -gqv '@agents_sessions_scope')"
agents="$(tmux show-option -gqv '@agents_sessions_agents')"
width="$(tmux show-option -gqv '@agents_sessions_popup_width')"
height="$(tmux show-option -gqv '@agents_sessions_popup_height')"
ui="$(tmux show-option -gqv '@agents_sessions_ui')"

[ -n "$key" ] || key='A'
[ -n "$scope" ] || scope='all'
[ -n "$agents" ] || agents='claude codex opencode pi'
[ -n "$width" ] || width='90%'
[ -n "$height" ] || height='80%'
[ -n "$ui" ] || ui='choose-tree'

agent_filter='#{||:#{m/r:π|opencode|codex|claude,#{pane_current_command} #{window_name} #{pane_title}},#{m/r:^[0-9]+\.[0-9]+\.[0-9]+$,#{pane_current_command}}}'
agent_format='#{?pane_format,#{@agents_state}  #{@agents_title},#{?window_format,#{@agents_state}  #{@agents_title},#{session_windows} windows#{?session_attached, (attached),}}}'

tmux set-option -gq '@agents_sessions_key' "$key"
tmux set-option -gq '@agents_sessions_scope' "$scope"
tmux set-option -gq '@agents_sessions_agents' "$agents"
tmux set-option -gq '@agents_sessions_popup_width' "$width"
tmux set-option -gq '@agents_sessions_popup_height' "$height"
tmux set-option -gq '@agents_sessions_ui' "$ui"

if [ "$ui" = 'choose-tree' ]; then
  tmux bind-key "$key" "run-shell -b '$SCRIPT pane-state-refresh'; choose-tree -Z -f '$agent_filter' -F '$agent_format' \"switch-client -t '%%'\""
else
  tmux bind-key "$key" display-popup -E -T ' agent sessions ' -w "$width" -h "$height" "$SCRIPT popup"
fi

tmux set-hook -g client-session-changed "run-shell -b '$SCRIPT cache-refresh; $SCRIPT pane-state-refresh'"
tmux set-hook -g session-created "run-shell -b '$SCRIPT cache-refresh; $SCRIPT pane-state-refresh'"
tmux set-hook -g session-closed "run-shell -b '$SCRIPT cache-refresh; $SCRIPT pane-state-refresh'"
tmux set-hook -g pane-exited "run-shell -b '$SCRIPT cache-refresh; $SCRIPT pane-state-refresh'"
tmux set-hook -g window-renamed "run-shell -b '$SCRIPT cache-refresh; $SCRIPT pane-state-refresh'"
tmux run-shell -b "$SCRIPT cache-refresh; $SCRIPT pane-state-refresh; $SCRIPT state-loop-start"
