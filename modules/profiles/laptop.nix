{ lib, ... }:

# Layer 3 — laptop.
#
# Imports graphical.nix (which imports base.nix), then declares only what makes
# this a laptop: Hyprland, Bluetooth hardware, and no NoMachine.
#
# GPU vendor is NOT set here — that is mySystem.hardware.gpu, set per host.

{
  imports = [ ./graphical.nix ];

  mySystem = {
    laptop.enable = lib.mkDefault true;
    hardware.bluetooth = lib.mkDefault true;

    environment = lib.mkDefault "hyprland";
    services.printing = lib.mkDefault true;

    # NoMachine is desktop-only; stated explicitly so the intent is visible.
    # podmanDesktop stays off too: this profile does not enable the Podman
    # engine, so the GUI would have no socket to talk to.
    packages.gui.nomachine = lib.mkDefault false;
    packages.gui.podmanDesktop = lib.mkDefault false;
  };
}
