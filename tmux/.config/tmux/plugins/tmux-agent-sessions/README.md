# tmux-agent-sessions

Popup view for active AI agent panes in tmux.

## Features

- Lists `claude`, `codex`, `opencode`, and `pi` panes by default.
- Shows a heuristic status: `running`, `waiting`, `idle`, or `dead`.
- Opens in a tmux popup, so it does not create a tmux window or tab.
- Uses a cache so the list appears immediately.
- Shows the selected pane preview on the right.
- Defaults to all tmux sessions, with the current session shown first.
- Press `Ctrl-A` inside the popup to show all tmux sessions, with the current session marked by `*`.

## Keybinding

Default keybinding: `prefix + A`

Inside the popup:

- `Enter`: focus the selected agent pane
- `Ctrl-R`: refresh
- `Ctrl-S`: show only the current tmux session
- `Ctrl-A`: show all tmux sessions
- `Esc`: close

## Options

Set these before loading the plugin:

```tmux
set -g @agents_sessions_key 'A'
set -g @agents_sessions_scope 'all' # current or all
set -g @agents_sessions_agents 'claude codex opencode pi'
set -g @agents_sessions_popup_width '90%'
set -g @agents_sessions_popup_height '80%'
```

Status detection is based on recent pane output, so it is best effort.
