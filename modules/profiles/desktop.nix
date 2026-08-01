{ ... }:

{
    mySystem = {
        desktop.enable = true;
        environment = "plasma6";
        desktop.amd = true;
        desktop.nvidia = false;
        cursor.enable = true;
        gaming.enable = true;
        gaming.steam = true;
        development.enable = true;
        development.godot = true;
        development.nixLd = true;
        shell.zsh = true;
        development.docker = true;
        networking.tailscale = true;

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
        packages.development.godot = true;

    };
}