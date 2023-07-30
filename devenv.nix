{ pkgs, ... }:

{
  packages = [
    pkgs.git
    pkgs.nodejs_20
    pkgs.yarn
    pkgs.nodePackages.pnpm
  ];
}

