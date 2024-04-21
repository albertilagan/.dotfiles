#!/usr/bin/env bash

tmux rename-window "vim"
cd $(go run ~/.dotfiles/bin/nvim-gw.go)
nvim $argv
