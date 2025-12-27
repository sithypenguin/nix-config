# Productivity apps
{ config, pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    libreoffice
    obsidian
    drawio
  ];
}
