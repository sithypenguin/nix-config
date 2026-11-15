{ lib, ... }:

# Layer 2 — anything with a display.
#
# Cursor theme, GUI applications, gaming, and the development tooling that
# only makes sense with a session to run in. Imports base.nix, so a host that
# imports this gets the CLI floor for free.
#
# Headless hosts must NOT import this: it pulls in GUI packages and a cursor
# theme that have nothing to attach to.
#
# GPU vendor is deliberately absent — that is mySystem.hardware.gpu, set per
# host, so a headless compute box can carry an NVIDIA card without a desktop.

{
    imports = [ ./base.nix ];

    mySystem = {
        cursor.enable = lib.mkDefault true;

        gaming.steam = lib.mkDefault true;

        development.godot = lib.mkDefault true;
        development.nixLd = lib.mkDefault true;

        packages.network.wireless = lib.mkDefault true;
        packages.network.bluetooth = lib.mkDefault true;

        packages.gui.base = lib.mkDefault true;
        packages.gui.multimedia = lib.mkDefault true;
        packages.gui.office = lib.mkDefault true;
        packages.gui.comms = lib.mkDefault true;
        packages.gui.design = lib.mkDefault true;
        packages.gui.tui = lib.mkDefault true;
        packages.gui.hermesDesktop = lib.mkDefault true;

        packages.gaming.steam = lib.mkDefault true;
        packages.development.godot = lib.mkDefault true;
    };
}
