{ ... }:

# Layer 3 — headless server.
#
# Imports base.nix only: a shell, CLI tools, and network diagnostics. No cursor
# theme, no GUI packages, no display manager. This is the profile that proves
# the layering works — it shares the floor with the desktops and nothing else.
#
# IMPORTANT: rootless Podman needs a user. Set it per-host, e.g. in
# hosts/<hostname>/default.nix:
#     mySystem.services.podman.user = "sithy";
# Evaluation fails with a clear assertion message if it is left unset.

{
    imports = [ ./base.nix ];

    mySystem = {
        environment = null;   # headless: no display manager / desktop environment

        services.podman.enable = true;
        services.podman.rootless = true;   # least privilege; set false for rootful Podman
        services.podman.compose = true;
    };
}
