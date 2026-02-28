# Design / creative tools
{ config, pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    pkgs-unstable.prusa-slicer
  ];
}
