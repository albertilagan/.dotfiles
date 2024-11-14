#!/usr/bin/env bash

layout_file="$HOME/.config/sesh/layouts/${1:-default}.yaml"

if [ ! -f "$layout_file" ]; then
	layout_file="$HOME/.config/sesh/layouts/default.yaml"
fi

tmuxp load $layout_file -a && tmux kill-window -t 1
