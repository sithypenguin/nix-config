{ ... }:

# Layer 3 — laptop.
#
# Imports graphical.nix (which imports base.nix), then declares only what makes
# this a laptop: Hyprland, Bluetooth hardware, and no NoMachine.

{
    imports = [ ./graphical.nix ];

    mySystem = {
        laptop.enable = true;
        hardware.bluetooth = true;

        environment = "hyprland";

        # NoMachine is desktop-only; stated explicitly so the intent is visible
        packages.gui.nomachine = false;
        packages.gui.podmanDesktop = true;
    };
}
