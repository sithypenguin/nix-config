{ ... }:

# Layer 1 — every host, graphical or not.
#
# This is the floor: a shell and the CLI tools you expect on any machine.
# A headless server imports this and stops here. Nothing in this file needs a
# display, a GPU, or a desktop session.
#
# Composition rule: profiles form a chain.
#   base.nix  →  graphical.nix  →  desktop.nix | laptop.nix
#                                 server.nix imports base.nix only

{
    mySystem = {
        shell.zsh = true;

        packages.base.core = true;
        packages.base.cliTools = true;
        packages.base.devTools = true;

        packages.network.base = true;
    };
}
