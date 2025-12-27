# Core GUI apps (DE-agnostic)
{ config, pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    pkgs-unstable.vscode
    bitwarden-desktop
    firefox
    networkmanagerapplet
  ];
}
