{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pkgs.vim
            pkgs.direnv
            pkgs.age
            pkgs.sshs
            pkgs.atac
            pkgs.termshark
            pkgs.portal
            pkgs.glow
            pkgs.neovim
            pkgs.gnupg
            pkgs.starship
            pkgs.lazygit
            pkgs.fish
            pkgs.stow
            pkgs.tmux
            pkgs.zf
            pkgs.fd
            pkgs.zoxide
            pkgs.glow
            pkgs.ripgrep
            pkgs.bat
            pkgs.lf
            pkgs.mkcert
            pkgs.neofetch
            pkgs.htop
            pkgs.eza
            pkgs.delta
            pkgs.kubectl
            pkgs.yazi
            pkgs.devenv
            pkgs.wget
            pkgs.docker
            pkgs.gh
            pkgs.lua51Packages.lua
            pkgs.luajitPackages.luarocks_bootstrap
            pkgs.nixd
            pkgs.nixfmt-rfc-style
            pkgs.ffmpeg
            pkgs.minikube
            pkgs.ngrok
            pkgs.tmuxp
            pkgs.k3d
            pkgs.postgresql
            pkgs.ansible
            pkgs.gcrane
          ];
          nixpkgs.config = {
            allowUnfree = true;
            allowBroken = false;
            allowUnsupportedSystem = false;
          };
          services.nix-daemon.enable = true;
          nix.enable = false
          nix.settings.experimental-features = "nix-command flakes";
          nix.settings.trusted-users = [
            "root"
            "albertilagan"
          ];
          # programs.zsh.enable = true;  # default shell on catalina
          programs.fish.enable = true;
          nixpkgs.hostPlatform = "aarch64-darwin";
          security.pam.enableSudoTouchIdAuth = true;

          users.users.albertilagan.home = "/Users/albertilagan";

          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 5;
          system.keyboard = {
            enableKeyMapping = true;
            remapCapsLockToControl = true;
          };
          system.defaults = {
            dock.autohide = true;
            dock.mru-spaces = false;
            dock.persistent-apps = [
              "/Applications/Safari.app"
              "/Applications/Wezterm.app"
              "/Applications/Arc.app"
              "/Applications/Discord.app"
            ];
            dock.show-process-indicators = true;
            dock.static-only = true;
            dock.show-recents = false;
            dock.tilesize = 30;
            finder.AppleShowAllExtensions = true;
            finder.CreateDesktop = false;
            finder.FXPreferredViewStyle = "Nlsv";
            finder.QuitMenuItem = true;
            finder.ShowPathbar = true;
            finder.ShowStatusBar = true;
            loginwindow.LoginwindowText = "sudo_al";
            screencapture.location = "~/Pictures/screenshots";
            screensaver.askForPasswordDelay = 10;
            spaces.spans-displays = false;
          };

          # Homebrew needs to be installed on its own!
          homebrew.enable = true;
          homebrew.casks = [
            "arc"
            "wireshark"
            "google-chrome"
            "wezterm"
            "font-fira-code-nerd-font"
            "1password"
            "1password-cli"
            "karabiner-elements"
            "nikitabobko/tap/aerospace"
            "discord"
            "google-cloud-sdk"
            "raycast"
            "amie"
            "postico"
            "tableplus"
            "cleanshot"
            "qmk-toolbox"
            "chatgpt"
            "bartender"
            "zed"
            "key-codes"
            "topnotch"
            "visual-studio-code"
            "whatsapp"
            "orbstack"
            "linear-linear"
            "jordanbaird-ice"
            "hammerspoon"
            "nordvpn"
            "firefox"
            "figma"
            "lens"
            "ghostty"
          ];
          homebrew.brews = [
            "imagemagick"
            "sesh"
            "fzf"
            "cloud-sql-proxy"
            "bash"
            "pam-reattach"
            "silicon"
            "watch"
            "showkey"
            "xdotool"
            "luarocks"
            "kubectx"
            "hashicorp/tap/terraform"
            "kubeone"
            "kubie"
          ];
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Alberts-MacBook-Pro
      darwinConfigurations."Alberts-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Alberts-MacBook-Pro".pkgs;
    };
}
