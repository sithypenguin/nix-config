{ config, pkgs, lib, ... }:

{
  config = lib.mkIf (config.mySystem.laptop.enable || config.mySystem.desktop.enable) {
    # Enable NetworkManager for network connectivity
    networking.networkmanager.enable = true;
  };
}