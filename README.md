# Project Nimbus

## Setup

1. Install [nix](https://nixos.org/download/)
2. Clone [.dotfiles](https://github.com/albertilagan/.dotfiles) to `~/.dotfiles`
3. Install and activate (skip `step 1`) [nix-darwin (flake)](https://github.com/LnL7/nix-darwin?tab=readme-ov-file#flakes)
4. activate nix-darwin `darwin-rebuild switch --flake ~/.dotfiles/nix-darwin`

## Additional Setup

1. sudo touch_id on tmux, `pam_reattach`

edit `/etc/pam.d/sudo`

```
auth     optional     /opt/homebrew/lib/pam/pam_reattach.so ignore_ssh
auth     sufficient   pam_tid.so # nix-darwin: security.pam.enableSudoTouchIdAuth
```
