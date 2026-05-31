# Core GUI apps (DE-agnostic)
{ config, pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    pkgs-unstable.vscode
    pkgs-unstable.bitwarden-desktop
    firefox
    networkmanagerapplet
    easyeffects
    chromium
    microsoft-edge
  ];
}
