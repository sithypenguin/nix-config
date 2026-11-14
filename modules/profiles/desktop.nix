{ ... }:

# Layer 3 — desktop.
#
# Imports graphical.nix (which imports base.nix), then declares only what makes
# this a desktop: Plasma 6 on AMD, Tailscale, and the two desktop-only packages.
#
# To add a third graphical host, copy this file's shape: import a layer,
# declare deltas. Never repeat the shared policy.

{
    imports = [ ./graphical.nix ];

    mySystem = {
        desktop.enable = true;
        desktop.amd = true;
        desktop.nvidia = false;

        environment = "plasma6";
        networking.tailscale = true;

        packages.gui.nomachine = true;
        packages.gui.podmanDesktop = true;
    };
}
