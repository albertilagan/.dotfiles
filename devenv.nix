{ pkgs, ... }:

{
  packages = [
    pkgs.git
    pkgs.nodejs_24
    pkgs.yarn
    pkgs.pnpm
  ];

  languages.go.enable = true;
}
