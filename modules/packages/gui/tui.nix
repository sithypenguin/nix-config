# GUI-adjacent TUI apps
{ config, pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    ncspot
  ];
}
