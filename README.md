# Project Nimbus

## Setup

1. Install [nix](https://nixos.org/download/)
2. Clone [.dotfiles](https://github.com/albertilagan/.dotfiles) to `~/.dotfiles`
3. Install and activate (skip `step 1`) [nix-darwin (flake)](https://github.com/LnL7/nix-darwin?tab=readme-ov-file#flakes)
4. activate nix-darwin `darwin-rebuild switch --flake ~/.dotfiles/nix-darwin`
