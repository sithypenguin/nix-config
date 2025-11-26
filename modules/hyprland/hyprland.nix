{ config, pkgs, pkgs-unstable,... }:

let 
    unstable = pkgs-unstable;
in
{ 
    home.packages = with pkgs; [
        # Hyprland Doc Must-Haves

        ## Notifications
        unstable.mako

        ## Audio
        unstable.pipewire
        unstable.wireplumber
        unstable.pavucontrol 

        ## Authentication
        unstable.hyprpolkitagent

        ## Desktop Portal
        xdg-desktop-portal-hyprland

        ## Status Bar
        unstable.waybar

        ## Wallpaper
        unstable.hyprpaper

        ## App Launcher
        unstable.rofi

        ## Clipboard manager
        unstable.wl-clipboard 
        unstable.cliphist # Dependency on wl-clipboard

        ## File manager
        xfce.thunar
        nemo-with-extensions
        mc # Midnight Commander

        ## Screen capture/recording
        unstable.grim
        unstable.slurp
        unstable.wf-recorder

        ## Calculator
        qalculate-gtk

        kvantum
        qt6.qtwayland
    ];

    qt = {
        enable = true;
        platformTheme.name = "kvantum";
        style.name = "kvantum";
    };

    # Simply enable the service that the package already provides
    services.hyprpolkitagent.enable = true;

    home.sessionVariables = {
        QT_QPA_PLATFORMTHEME = "kvantum";
    };
}