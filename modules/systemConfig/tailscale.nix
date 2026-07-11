{ config, lib, pkgs, ...}:

{ 
    config = lib.mkIf (config.mySystem.desktop.enable && config.mySystem.networking.tailscale) {
        services.tailscale.enable = true;
    };
}