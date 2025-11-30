{ config, pkgs, lib, ... }:

{
  config = lib.mkIf (config.mySystem.laptop.enable || config.mySystem.desktop.enable) {
    # Enable NetworkManager for network connectivity
    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.powersave = false;
    # Enable gnome-keyring for storing WiFi passwords
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;
  };
}