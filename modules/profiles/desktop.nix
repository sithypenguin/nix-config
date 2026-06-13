{ ... }:

{
    mySystem = {
        desktop.enable = true;
        desktop.environment = "plasma6";
        #desktop.environment = "hyprland";
        desktop.amd = true;
        desktop.nvidia = false;
        gaming.enable = true;
        gaming.steam = true;
        development.enable = true;
        development.godot = true;
        shell.zsh = true;

        # Package categories for this profile
        packages.base.core = true;
        packages.base.cliTools = true;
        packages.base.devTools = true;
        packages.network.base = true;
        packages.network.wireless = true;
        packages.network.bluetooth = true;
        packages.gui.base = true;
        packages.gui.multimedia = true;
        packages.gui.office = true;
        packages.gui.comms = true;
        packages.gui.design = true;
        packages.gui.tui = true;
        packages.gaming.steam = true;

        # Desktop environments
        desktopEnvironments.plasma6 = true;
    };
}