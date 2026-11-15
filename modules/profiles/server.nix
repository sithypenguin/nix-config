{ lib, ... }:

# Layer 3 — headless server.
#
# Imports base.nix only: a shell, CLI tools, and network diagnostics. No cursor
# theme, no GUI packages, no display manager. This is the profile that proves
# the layering works — it shares the floor with the desktops and nothing else.
#
# Rootless Podman needs a user, but it no longer has to be repeated per host:
# mySystem.services.podman.user defaults to mySystem.primaryUser. Override
# either one in the host file if a machine needs a different account.
#
# SSH is on by default here: a homelab server with no remote shell is not
# reachable. Set mySystem.services.openssh = false to opt out.

{
    imports = [ ./base.nix ];

    mySystem = {
        environment = lib.mkDefault null;   # headless: no display manager / desktop environment

        services.openssh = lib.mkDefault true;

        services.podman.enable = lib.mkDefault true;
        services.podman.rootless = lib.mkDefault true;   # least privilege; set false for rootful Podman
        services.podman.compose = lib.mkDefault true;
    };
}
