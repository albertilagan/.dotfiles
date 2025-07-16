# TODO: replace with home-manager
# stow
stow aerospace
stow bat
stow direnv
stow fish
stow nvim
stow sesh
# stow sketchybar
stow starship
stow tmux
stow wezterm
stow yazi
# stow zsh
stow ghostty

# add fish to valid login shells
command -v fish | sudo tee -a /etc/shells

# use fish as default shell
sudo chsh -s "$(command -v fish)" "${USER}"

bat cache --build

# protols lsp
nix-shell -p cargo -p libiconv --command "cargo install protols"
