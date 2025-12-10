# Dotfiles

## Setup

1. Clone [.dotfiles](https://github.com/albertilagan/.dotfiles) to `~/.dotfiles`
2. Install nix

```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

> if asked if you wanna `Install Determinate Nix`, type `no`.

3. Install [brew](https://docs.brew.sh/Installation)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

post-brew installation

```
brew tap hashicorp/tap \
  && brew tap redpanda-data/tap \
  && brew tap siderolabs/tap
```

4. Install nix-darwin

```bash
sudo nix --extra-experimental-features 'flakes nix-command' run nix-darwin -- switch --flake ~/.dotfiles/nix-darwin
```

5. activate nix-darwin

```bash
sudo darwin-rebuild switch --flake ~/.dotfiles/nix-darwin
```

6. stow apps, `./install.sh`

## Additional Setup

1. sudo touch_id on tmux, `pam_reattach`

edit `/etc/pam.d/sudo`

```
auth     optional     /opt/homebrew/lib/pam/pam_reattach.so ignore_ssh
auth     sufficient   pam_tid.so # nix-darwin: security.pam.enableSudoTouchIdAuth
```
