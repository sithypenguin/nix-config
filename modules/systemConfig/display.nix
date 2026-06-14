# Display server and desktop environment configuration
# Configures X11, display manager, desktop environment, and keyboard layout
{ config, pkgs, lib, ... }:

{
    config = lib.mkIf (config.mySystem.environment != null) (lib.mkMerge [
      {
        # X11 windowing system
        services.xserver.enable = true;

        # SDDM is used for both Plasma and Hyprland sessions.
        services.displayManager.sddm.enable = true;

        # XDG Desktop Portal configuration
        /*xdg.portal = {
            enable = true;
            extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
            config.common.default = "kde"; # Forces KDE portal for all requests
        };*/

        # Keyboard configuration for X11
        services.xserver.xkb = {
            layout = "us";      # US keyboard layout
            variant = "";       # No keyboard variant (default US layout)
        };

        # Enable touchpad support for laptops
        services.libinput.enable = lib.mkIf config.mySystem.laptop.enable true;
            }
            (lib.mkIf (config.mySystem.environment == "plasma6") {
                services.desktopManager.plasma6.enable = true;
            })
            (lib.mkIf (config.mySystem.environment == "hyprland") {
                services.desktopManager.plasma6.enable = false;
            })
        ]);
}