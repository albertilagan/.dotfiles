#!/usr/bin/env bash
# Toggle a dedicated claude code pane (show/hide without killing)
PANE_ID=$(tmux show-environment -g CLAUDE_PANE 2>/dev/null | sed 's/CLAUDE_PANE=//')

if [ -n "$PANE_ID" ] && tmux list-panes -a -F '#{pane_id}' | grep -qF "$PANE_ID"; then
  PANE_WIN=$(tmux list-panes -a -F '#{pane_id} #{window_id}' | awk -v id="$PANE_ID" '$1==id{print $2}')
  CUR_WIN=$(tmux display-message -p '#{window_id}')

  if [ "$PANE_WIN" = "$CUR_WIN" ]; then
    tmux break-pane -d -s "$PANE_ID" -n _claude_hidden
  else
    tmux join-pane -h -s "$PANE_ID" -l 40%
    tmux select-pane -t "$PANE_ID"
  fi
else
  tmux split-window -h -l 40% claude
  tmux set-environment -g CLAUDE_PANE "$(tmux display-message -p '#{pane_id}')"
fi
