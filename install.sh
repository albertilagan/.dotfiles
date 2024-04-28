# install/run nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
else
	command -v nix &>/dev/null || curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
fi

echo "trusted-users = root $USER" | sudo tee -a /etc/nix/nix.conf && sudo pkill nix-daemon

# install cachix
if ! command -v cachix &>/dev/null; then
	nix --experimental-features 'nix-command flakes' profile install nixpkgs#cachix
	cachix use devenv
fi

# install devenv
command -v devenv &>/dev/null || nix --experimental-features 'nix-command flakes' profile install --accept-flake-config github:cachix/devenv/latest

nix --experimental-features 'nix-command flakes' profile install --priority 4 \
	nixpkgs#zsh \
	nixpkgs#fish \
	nixpkgs#starship \
	nixpkgs#git \
	nixpkgs#lazygit \
	nixpkgs#neovim \
	nixpkgs#vimPlugins.LazyVim \
	nixpkgs#stow \
	nixpkgs#tmux \
	nixpkgs#fzf \
	nixpkgs#zf \
	nixpkgs#fd \
	nixpkgs#direnv \
	nixpkgs#zoxide \
	nixpkgs#glow \
	nixpkgs#ripgrep \
	nixpkgs#bat \
	nixpkgs#exa \
	nixpkgs#lf \
	nixpkgs#gnupg \
	nixpkgs#mkcert \
	nixpkgs#neofetch \
	nixpkgs#htop \
	nixpkgs#sesh \
	nixpkgs#eza \
	nixpkgs#delta \
	nixpkgs#kubectl \
	nixpkgs#kubectx \
	nixpkgs#yazi \

# stow
stow alacritty
stow bat
stow fish
stow nvim
stow skhd
stow starship
stow tmux
stow yabai
stow zsh
stow wezterm
stow sesh
stow yazi
stow sketchybar

# add fish to valid login shells
command -v fish | sudo tee -a /etc/shells

# use fish as default shell
sudo chsh -s "$(command -v fish)" "${USER}"
