# Dotfiles

## Setup

1. Install nix
```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```
> if asked if you wanna `Install Determinate Nix`, type `no`.
2. Install [brew](https://docs.brew.sh/Installation)
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# tmp brew activation
echo >> /Users/albert/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/albert/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```
post-brew installation
  - `brew tap hashicorp/tap`
  - `brew tap redpanda-data/tap`
  - `brew tap goreleaser/tap`
3. Clone [.dotfiles](https://github.com/albertilagan/.dotfiles) to `~/.dotfiles`
4. Install nix-darwin `nix --extra-experimental-features 'flakes nix-command' run nix-darwin -- switch --flake ~/.dotfiles/nix-darwin`
5. activate nix-darwin `darwin-rebuild switch --flake ~/.dotfiles/nix-darwin`
6. stow apps, `./install.sh`

## Additional Setup

1. sudo touch_id on tmux, `pam_reattach`

edit `/etc/pam.d/sudo`

```
auth     optional     /opt/homebrew/lib/pam/pam_reattach.so ignore_ssh
auth     sufficient   pam_tid.so # nix-darwin: security.pam.enableSudoTouchIdAuth
```
