{ config, pkgs, ... }:

{ 
    wayland.windowManager.hyprland = {
        enable = true;

        settings = {
            monitor = ",preferred,auto,1";

            input = {
                kb_layout = "us";
                follow_mouse = "1";
                touchpad = {
                    natural_scroll = true;
                };
                sensitivity = 0;
            }
        }
    };

    home.packages = with pkgs; [
        # Hyprland Doc Must-Haves

        ## Notifications
        mako

        ## Audio
        pipewire
        wireplumber

        ## Authentication
        hyprpolkitagent

        ## Desktop Portal
        xdg-desktop-portal-hyprland

        ## Status Bar
        waybar

        ## Wallpaper
        hyprpaper

        ## App Launcher
        rofi

        ## Clipboard manager
        wl-clipboard 
        cliphist # Dependency on wl-clipboard

        ## File manager
        xfce.thunar
        nemo-with-extensions
        mc # Midnight Commander
        
    ]
}