# Display server and desktop environment configuration
# Configures X11, display manager, desktop environment, and keyboard layout
{ config, pkgs, lib, ... }:

{
    # X11 windowing system
    services.xserver.enable = true;                 # Enable the X11 windowing system
    
    # Display and desktop environment
    services.displayManager.sddm.enable = lib.mkIf (config.mySystem.desktop.environment == "plasma6") true;
    services.desktopManager.plasma6.enable = lib.mkIf (config.mySystem.desktop.environment == "plasma6") true;

    # Keyboard configuration for X11
    services.xserver.xkb = {
        layout = "us";      # US keyboard layout
        variant = "";       # No keyboard variant (default US layout)
    };
}