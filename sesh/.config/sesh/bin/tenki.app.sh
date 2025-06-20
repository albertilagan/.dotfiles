#!/bin/bash

# Split specified tmux window into 2x2 grid with narrow top-right pane
# Usage: tenki.app.sh <window_index>

WINDOW_INDEX=${1:-1}

# Split window vertically (creates top and bottom panes)
tmux split-window -v -t $WINDOW_INDEX

# Split top pane horizontally
tmux split-window -h -p 25 -t $WINDOW_INDEX.1

# Split bottom horizontally
tmux split-window -h -t $WINDOW_INDEX.3

# Run 'dev logs engine' in each pane
tmux send-keys -t $WINDOW_INDEX.1 'dev logs engine' Enter
tmux send-keys -t $WINDOW_INDEX.2 'dev logs sqlc-watch' Enter
tmux send-keys -t $WINDOW_INDEX.3 'dev logs app' Enter
tmux send-keys -t $WINDOW_INDEX.4 'dev logs github-proxy' Enter

# Select the top-left pane
tmux select-pane -t $WINDOW_INDEX.1
