# Display server and desktop environment configuration
# Configures X11, display manager, desktop environment, and keyboard layout
{ config, pkgs, lib, ... }:

{
    config = lib.mkIf (config.mySystem.laptop.enable || config.mySystem.desktop.enable) {
        # X11 windowing system
        services.xserver.enable = true;
        
        # Display and desktop environment - use laptop environment if laptop is enabled
        services.displayManager.sddm.enable = lib.mkIf 
            ((config.mySystem.laptop.enable && config.mySystem.laptop.environment == "plasma6") ||
             (!config.mySystem.laptop.enable && config.mySystem.desktop.environment == "plasma6")
             (config.mySystem.laptop.enable && config.mySystem.laptop.environment == "hyprland")) true;
             
        services.desktopManager.plasma6.enable = lib.mkIf 
            ((config.mySystem.laptop.enable && config.mySystem.laptop.environment == "plasma6") ||
             (!config.mySystem.laptop.enable && config.mySystem.desktop.environment == "plasma6")) true;


        # Keyboard configuration for X11
        services.xserver.xkb = {
            layout = "us";      # US keyboard layout
            variant = "";       # No keyboard variant (default US layout)
        };

        # Enable touchpad support for laptops
        services.libinput.enable = lib.mkIf config.mySystem.laptop.enable true;
    };
}