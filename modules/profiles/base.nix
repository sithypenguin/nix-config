{ lib, ... }:

# Layer 1 — every host, graphical or not.
#
# This is the floor: a shell and the CLI tools you expect on any machine.
# A headless server imports this and stops here. Nothing in this file needs a
# display, a GPU, or a desktop session.
#
# Composition rule: profiles form a chain.
#   base.nix  →  graphical.nix  →  desktop.nix | laptop.nix
#                                 server.nix imports base.nix only
#
# Every value is lib.mkDefault so a host file can override it plainly:
#   mySystem.packages.base.cliTools = false;
# Without mkDefault the host's value and the profile's value are equal-priority
# and evaluation fails with "conflicting definition values".

{
  mySystem = {
    shell.zsh = lib.mkDefault true;

    packages.base.core = lib.mkDefault true;
    packages.base.cliTools = lib.mkDefault true;
    packages.base.devTools = lib.mkDefault true;

    packages.network.base = lib.mkDefault true;
  };
}
