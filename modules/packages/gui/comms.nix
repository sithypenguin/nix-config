# Communication apps
{ config, pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    discord
    telegram-desktop
    element-desktop
  ];
}
