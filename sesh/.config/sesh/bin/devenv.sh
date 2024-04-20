#!/usr/bin/env bash

tmux rename-window "vim"
tmux new-window && tmux rename-window "devenv"
tmux selectw -t 1
tmux send-keys "nvim" Enter
tmux selectw -t 2
tmux send-keys "devenv up" Enter
tmux split-window -v -l 20 "dev start"
tmux select-pane -t :.+

