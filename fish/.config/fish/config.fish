set fish_function_path $fish_function_path ~/.config/fish/github/plugin-foreign-env/functions

eval (/opt/homebrew/bin/brew shellenv)
eval ($HOME/.nix-profile/bin/direnv hook fish)
eval (fzf_configure_bindings --git_status=\cg --history=\cr --variables=\cv --directory=\cd)
starship init fish | source
zoxide init fish | source

source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
source /Users/albertilagan/google-cloud-sdk/path.fish.inc

fenv "[ -f ~/fubectl.source ] && source ~/fubectl.source"

fish_add_path ~/.config/bin
fish_add_path ~/.nix-profile/bin
fish_add_path ~/.config/tmux/plugins/t-smart-tmux-session-manager/bin

set -U fish_greeting # disable fish greeting
set -U fish_key_bindings fish_vi_key_bindings
# set -U fish_key_bindings fish_default_key_bindings

set -Ux EDITOR nvim
set -Ux BAT_THEME Catppuccin-mocha
set -Ux FZF_DEFAULT_COMMANDS "fd -H -E '.git'"
set -Ux FZF_TMUX_OPTS "-p 55%,60%"
set -Ux VISUAL nvim

abbr fishrc "nvim ~/.config/fish/config.fish"
abbr zshrc "nvim ~/.zshrc"
abbr vimrc "nvim ~/.config/nvim/"
abbr tmuxconf "nvim ~/.config/tmux/tmux.conf"

abbr c clear
abbr pn pnpm
abbr lf lfcd
abbr vim nvim
abbr lg lazygit
abbr v nvim
abbr ip "ifconfig en0 | grep inet | awk '{ print \$2 }'"
abbr nix "nix --extra-experimental-features 'nix-command flakes'"

abbr l "lsd --group-dirs first -A"
abbr ls "lsd --group-dirs first -A"
abbr ll "lsd --group-dirs first -Al"
abbr lt "lsd --group-dirs last -A --tree"

abbr cat "bat --style=plain"
abbr fme "~/.dotfiles/scripts/search.sh"

abbr p "pnpm run (jq -r '.scripts|to_entries[]|((.key))' package.json | fzf-tmux -p --border-label='pnpm run')"

abbr gfo "git fetch origin"
abbr gfa "git fetch --all"
abbr gfp "git fetch --prune"
abbr gc "git commit -m"
abbr gca "git commit -am"
abbr gco "git checkout"
abbr gcb "git checkout -b"

abbr core-proxy "cloud_sql_proxy -instances=analog-stage-198105:us-central1:core-replica=tcp:8912"

abbr k kubectl

abbr yabai-restart "sh ~/.dotfiles/restart-yabai.sh"
