{ config, pkgs, pkgs-unstable,... }:

{ 
    home.packages = with pkgs; [
        # Hyprland Doc Must-Haves

        ## Notifications
        mako

        ## Audio
        pipewire
        wireplumber
        pavucontrol 

        ## Authentication
        hyprpolkitagent

        ## Desktop Portal
        xdg-desktop-portal-hyprland

        ## Status Bar
        waybar

        ## Wallpaper
        hyprpaper

        ## App Launcher
        pkgs-unstable.rofi

        ## Clipboard manager
        wl-clipboard 
        cliphist # Dependency on wl-clipboard

        ## File manager
        xfce.thunar
        nemo-with-extensions
        mc # Midnight Commander

        ## Screen capture/recording
        grim
        slurp
        wf-recorder

        ## Calculator
        qalculate-gtk
        
    ];
}