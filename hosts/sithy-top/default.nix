{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/profiles/desktop.nix
    ];

    networking.hostName = "sithy-top";
}