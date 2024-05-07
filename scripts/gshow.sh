#!/bin/bash

preview() {
  set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); 
  [ $# -eq 0 ] || git show --color=always $1; 
}

export -f preview 

# Fuzzy search over Git commits
# Enter will view the commit
# Ctrl-o will checkout the selected commit
function fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --preview 'bash -c "preview {}"' \
      --bind "ctrl-d:preview-page-down,ctrl-u:preview-page-up" \
      # --header "enter to view, ctrl-o to checkout" \
      # --bind "ctrl-o:become:(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs git checkout)" \
      # --bind "ctrl-m:execute:
      #           (grep -o '[a-f0-9]\{7\}' | head -1 |
      #           xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
      #           {}
# FZF-EOF" --preview-window=right:60%
}
fshow "$@"
