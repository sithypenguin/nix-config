{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/profiles/laptop.nix
    ];

    networking.hostName = "sithy-one";
}