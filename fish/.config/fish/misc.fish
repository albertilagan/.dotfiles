abbr c clear
abbr pn pnpm
abbr lf lfcd
abbr vim nvim
abbr lg lazygit
abbr ip "ifconfig en0 | grep inet | awk '{ print \$2 }'"
abbr sops "sops --in-place"
abbr da "direnv allow"
abbr v nvim

# abbr docker "podman"
# alias docker "podman"
alias co "container"

alias sf superfile
alias v nvim

alias l "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first"
alias ls "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first"
alias ll "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first"

alias cat "bat --style=plain"
alias nixd-reload "sudo darwin-rebuild switch --flake ~/.dotfiles/nix-darwin"
alias nixd-config "nvim ~/.dotfiles/nix-darwin/flake.nix"

abbr p "pnpm run (jq -r '.scripts|to_entries[]|((.key))' package.json | fzf-tmux -p --border-label='pnpm run')"
