{ config, lib, pkgs, ... }:

# Podman container engine.
#
# Rootless mode (default) runs containers as `mySystem.services.podman.user`,
# following the principle of least privilege. Set `rootless = false` to switch
# to the system-wide (rootful) Podman API socket instead.

let
    cfg = config.mySystem.services.podman;
in
{
    config = lib.mkIf cfg.enable (lib.mkMerge [
        # ========== COMMON (rootless + rootful) ==========
        {
            assertions = [
                {
                    assertion = !cfg.rootless || cfg.user != "";
                    message = "mySystem.services.podman.user must be set when mySystem.services.podman.rootless = true.";
                }
                {
                    assertion = !(cfg.dockerCompat && config.virtualisation.docker.enable);
                    message = "mySystem.services.podman.dockerCompat conflicts with Docker (mySystem.development.docker). Disable one of them.";
                }
            ];

            virtualisation.podman = {
                enable = true;
                dockerCompat = cfg.dockerCompat;
                # Lets containers on the default network resolve each other by name
                # (required for compose service-to-service networking).
                defaultNetwork.settings.dns_enable = true;
            };

            environment.systemPackages = [
                pkgs.podman
            ] ++ lib.optionals cfg.compose [
                pkgs.podman-compose
            ];
        }

        # ========== ROOTLESS ==========
        # Note: `user` must be an existing account (users/users.nix); otherwise NixOS
        # fails evaluation with an "isNormalUser / isSystemUser" assertion for it.
        (lib.mkIf (cfg.rootless && cfg.user != "") {
            # Rootless containers need subordinate UID/GID ranges (/etc/subuid, /etc/subgid)
            # to map container users into the host user namespace. Without them, image
            # pulls and container starts fail with "insufficient UIDs or GIDs" errors.
            # NixOS allocates a unique, non-overlapping 65536-ID range per user.
            users.users.${cfg.user} = {
                autoSubUidGidRange = true;
                # Keep the user's systemd instance (and therefore rootless containers)
                # running without an active login session - essential on a headless server.
                linger = lib.mkDefault true;
            };

            # Per-user Podman API socket ($XDG_RUNTIME_DIR/podman/podman.sock), used by
            # cockpit-podman and Docker-API compatible tools. The unit is shipped by the
            # podman package; restrict it to the configured user only.
            systemd.user.sockets.podman = {
                wantedBy = [ "sockets.target" ];
                unitConfig.ConditionUser = cfg.user;
            };
        })

        # ========== ROOTFUL (system-wide) ==========
        (lib.mkIf (!cfg.rootless) {
            # System Podman API socket (/run/podman/podman.sock), root-owned.
            systemd.sockets.podman.wantedBy = [ "sockets.target" ];
        })
    ]);
}