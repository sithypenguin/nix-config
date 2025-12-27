# Wireless tools (laptop-focused)
{ config, pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    networkmanagerapplet  # NM tray app (GUI)
    iw                     # Wireless tools
  ];
}
