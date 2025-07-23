# TODO: replace with home-manager
# stow
stow aerospace
stow bat
stow direnv
stow fish
stow nvim
stow sesh
# stow sketchybar
stow lazygit
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

# change npm location to solve the permission issue on nix
echo "prefix = ${HOME}/.npm-packages" >>~/.npmrc

git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.dotfiles/tmux/.config/tmux/plugins/catppuccin/tmux
git clone https://github.com/tmux-plugins/tpm ~/.dotfiles/tmux/.config/tmux/plugins/tpm
git clone https://github.com/fcsonline/tmux-thumbs ~/.dotfiles/tmux/.config/tmux/plugins/tmux-thumbs
