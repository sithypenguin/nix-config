{ ... }:

# Layer 2 — anything with a display.
#
# Cursor theme, GUI applications, gaming, and the development tooling that
# only makes sense with a session to run in. Imports base.nix, so a host that
# imports this gets the CLI floor for free.
#
# Headless hosts must NOT import this: it pulls in GUI packages and a cursor
# theme that have nothing to attach to.

{
    imports = [ ./base.nix ];

    mySystem = {
        cursor.enable = true;

        gaming.steam = true;

        development.godot = true;
        development.nixLd = true;

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
