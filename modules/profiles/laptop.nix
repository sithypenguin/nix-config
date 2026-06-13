{ ... }:

{
    mySystem = {
        laptop.enable = true;
        #laptop.environment = "plasma6";
        laptop.environment = "hyprland";
        gaming.enable = true;
        gaming.steam = true;
        development.enable = true;
        hardware.bluetooth = true;
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

        # Desktop environments
        desktopEnvironments.hyprland = true;
        laptopEnvironments.hyprland = true;
    };
}
