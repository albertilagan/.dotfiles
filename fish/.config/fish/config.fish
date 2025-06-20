set fish_function_path $fish_function_path ~/.config/fish/github/plugin-foreign-env/functions

eval (/opt/homebrew/bin/brew shellenv)
eval (/run/current-system/sw/bin/direnv hook fish)

starship init fish | source
zoxide init fish | source
# tug completion fish | source

# fish_add_path ~/.nix-profile/bin
fish_add_path ~/.config/bin
fish_add_path /usr/local/go/bin
fish_add_path ~/.locize-cli/bin
fish_add_path /opt/homebrew/opt/fzf/bin
fish_add_path /Applications/Ghostty.app/Contents/MacOS
fish_add_path ~/miniforge3/bin

set -U fish_greeting # disable fish greeting
set -U fish_key_bindings fish_vi_key_bindings # fish_default_key_bindings
set -x BAT_THEME Catppuccin-mocha
set -x VISUAL nvim
set -x EDITOR nvim
set -x CONFIG_DIR "$HOME/.config/lazygit"

source "$GHOSTTY_RESOURCES_DIR"/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish
source ~/.config/fish/keys.fish
source ~/.config/fish/fzf.fish
source ~/.config/fish/git.fish
source ~/.config/fish/misc.fish
source ~/.config/fish/kubernetes.fish
test -f ~/.config/fish/kubernetes.fish && source \
     (cat ~/.config/fish/kubernetes.fish | sed -r 's/(kubectl.*) --watch/watch \1/g' | psub)
# source ~/.config/fish/carapace.fish

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# Created by `pipx` on 2025-04-24 16:18:34
set PATH $PATH /Users/albert/.local/bin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/albert/miniforge3/bin/conda
    eval /Users/albert/miniforge3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/Users/albert/miniforge3/etc/fish/conf.d/conda.fish"
        . "/Users/albert/miniforge3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/Users/albert/miniforge3/bin" $PATH
    end
end
# <<< conda initialize <<<


# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/albert/.lmstudio/bin

# opencode
fish_add_path /Users/albert/.opencode/bin
