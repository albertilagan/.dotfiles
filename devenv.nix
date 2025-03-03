{ pkgs, ... }:

{
  packages = [
    pkgs.git
    pkgs.nodejs_22
    pkgs.yarn
    pkgs.nodePackages.pnpm
  ];

  languages.go.enable = true;
}
