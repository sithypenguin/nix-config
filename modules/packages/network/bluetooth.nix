# Bluetooth utilities (optional)
{ config, pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    bluetui   # TUI Bluetooth manager
  ];
}
