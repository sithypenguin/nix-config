{ config, lib, pkgs, ... }:

# Cockpit web management UI (https://<host>:<port>).
#
# Cockpit authenticates via PAM, so you log in with your normal system user
# account - no extra user setup is needed. Rootless containers show up when you
# log in as the Podman user; rootful containers need Cockpit's "administrative
# access" (sudo) toggle.

let
    cfg = config.mySystem.services.cockpit;
in
{
    config = lib.mkIf cfg.enable {
        services.cockpit = {
            enable = true;
            port = cfg.port;
            openFirewall = cfg.openFirewall;
            # cockpit-podman adds the "Podman containers" page (images, containers,
            # pods, logs). It is packaged in the pinned nixpkgs (nixos-26.05).
            # Only added when Podman is enabled, since the plugin is useless without it.
            plugins = lib.optionals config.mySystem.services.podman.enable [
                pkgs.cockpit-podman
            ];
        };

        environment.systemPackages = [
            pkgs.cockpit
        ];
    };
}