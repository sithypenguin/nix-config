{ ... }:

# Headless server profile (stub).
#
# Manage containers through the Cockpit web UI at https://<server-ip>:9090.
#
# IMPORTANT: rootless Podman needs a user. Set it per-host, e.g. in
# hosts/<hostname>/default.nix:
#     mySystem.services.podman.user = "sithy";
# Evaluation fails with a clear assertion message if it is left unset.

{
    mySystem = {
        environment = null;   # headless: no display manager / desktop environment
        shell.zsh = true;

        # Containers + web management
        services.podman.enable = true;
        services.podman.rootless = true;   # least privilege; set false for rootful Podman
        services.podman.compose = true;
        services.cockpit.enable = true;
        services.cockpit.openFirewall = true;

        # Package categories for this profile
        packages.base.core = true;
        packages.base.cliTools = true;
        packages.network.base = true;

    };
}