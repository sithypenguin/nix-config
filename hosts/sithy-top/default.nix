{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/profiles/desktop.nix
    ];

    mySystem.services.ollama.enable = true;

    networking.hostName = "sithy-top";
}