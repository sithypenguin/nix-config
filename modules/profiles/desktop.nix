{ lib, ... }:

# Layer 3 — desktop.
#
# Imports graphical.nix (which imports base.nix), then declares only what makes
# this a desktop: Plasma 6, Tailscale, printing, and the two desktop-only
# packages.
#
# GPU vendor is NOT set here — that is mySystem.hardware.gpu, set per host, so
# two desktops with different cards share this profile.
#
# To add another desktop host: one line in flake.nix, plus a hosts/<name>/
# directory holding hardware-configuration.nix, a hostname, and its GPU vendor.

{
  imports = [ ./graphical.nix ];

  mySystem = {
    desktop.enable = lib.mkDefault true;

    environment = lib.mkDefault "plasma6";
    networking.tailscale = lib.mkDefault true;
    services.printing = lib.mkDefault true;

    packages.gui.nomachine = lib.mkDefault true;
    packages.gui.podmanDesktop = lib.mkDefault true;
  };
}
