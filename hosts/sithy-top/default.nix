{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/profiles/desktop.nix
    ];

    mySystem.services.ollama.enable = true;
    mySystem.gaming.gamescope = true;

    # Podman + Cockpit test drive before moving to the server profile.
    # Web UI: https://localhost:9090 (log in as sithy)
    mySystem.services.podman.enable = true;
    mySystem.services.podman.user = "sithy";
    mySystem.services.cockpit.enable = true;

    networking.hostName = "sithy-top";
}