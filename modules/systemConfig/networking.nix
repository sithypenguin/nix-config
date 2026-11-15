{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Gated on the option alone. The old laptop/desktop conjunct could not express
  # a server with NetworkManager, which is how a homelab box gets a static IP,
  # bond or VLAN set declaratively.
  config = lib.mkIf config.mySystem.networking.networkmanager {
    # Enable NetworkManager for network connectivity
    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.powersave = false;

    # Enable gnome-keyring for storing WiFi passwords
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;

    # KDE Connect daemon and ports for phone pairing/discovery.
    programs.kdeconnect.enable = true;
    networking.firewall.allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    networking.firewall.allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
}
