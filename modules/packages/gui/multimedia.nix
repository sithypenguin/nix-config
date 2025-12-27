# Multimedia apps
{ config, pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    vlc
    spotify
    pavucontrol
  ];
}
