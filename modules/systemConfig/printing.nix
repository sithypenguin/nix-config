{ config, pkgs, lib, ... }:

{
  config = lib.mkIf (config.mySystem.laptop.enable || config.mySystem.desktop.enable) {
    # Enable CUPS to print documents
    services.printing.enable = true;
    
    # Enable automatic printer discovery
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    
    # Common printer drivers
    services.printing.drivers = with pkgs; [
      gutenprint
      hplip
      epson-escpr
      brlaser
    ];
  };
}