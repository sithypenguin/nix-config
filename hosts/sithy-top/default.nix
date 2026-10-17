{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/profiles/desktop.nix
    ];

    mySystem.services.ollama.enable = true;
    mySystem.gaming.gamescope = true;

    # Podman is enabled for local container management via Podman Desktop.
    mySystem.services.podman.enable = true;
    mySystem.services.podman.user = "sithy";

    networking.hostName = "sithy-top";
}