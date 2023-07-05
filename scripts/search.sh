#!/usr/bin/env bash

# 1. Search for text in files using Ripgrep
# 2. Interactively restart Ripgrep with reload action
# 3. Open the file in Vim
RG_PREFIX="rg --column -n --no-heading --color=always -S -F "
INITIAL_QUERY="${*:-}"
IFS=: read -ra selected < <(
	FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" \
		fzf --ansi --reverse \
		--disabled --query "$INITIAL_QUERY" \
		--bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
		--delimiter : \
		--preview 'bat --color=always {1} --highlight-line {2}' \
		--preview-window right
)
[ -n "${selected[0]}" ] && nvim "+call cursor(${selected[1]}, ${selected[2]})" ${selected[0]}
