set fish_function_path $fish_function_path ~/.config/fish/github/plugin-foreign-env/functions

eval (/opt/homebrew/bin/brew shellenv)
eval (/run/current-system/sw/bin/direnv hook fish)

starship init fish | source
zoxide init fish | source
# tug completion fish | source

# fish_add_path ~/.nix-profile/bin
fish_add_path ~/.config/bin
fish_add_path ~/.lmstudio/bin
fish_add_path ~/.local/bin
fish_add_path ~/.locize-cli/bin
fish_add_path ~/.opencode/bin
fish_add_path ~/miniforge3/bin
fish_add_path /usr/local/go/bin
fish_add_path /opt/homebrew/opt/fzf/bin
fish_add_path /Applications/Ghostty.app/Contents/MacOS
fish_add_path ~/.npm-packages/bin

set -U fish_greeting # disable fish greeting
set -U fish_key_bindings fish_vi_key_bindings # fish_default_key_bindings
set -x BAT_THEME Catppuccin-mocha
set -x VISUAL nvim
set -x EDITOR nvim
set -x CONFIG_DIR "$HOME/.config/lazygit"

# source ~/.config/fish/keys.fish
source "$HOME/.cargo/env.fish"
source ~/.config/fish/fzf.fish
source ~/.config/fish/git.fish
source ~/.config/fish/misc.fish
source ~/.config/fish/kubernetes.fish
