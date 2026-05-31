{ config, pkgs, lib, ... }:

{
  config = lib.mkIf (config.mySystem.laptop.enable || config.mySystem.desktop.enable) {
    # Enable NetworkManager for network connectivity
    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.powersave = false;
    
    # Enable gnome-keyring for storing WiFi passwords
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;

    # KDE Connect daemon and ports for phone pairing/discovery.
    programs.kdeconnect.enable = true;
    networking.firewall.allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    networking.firewall.allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };
}