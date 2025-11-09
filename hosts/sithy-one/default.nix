{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../profiles/laptop.nix
    ];

    networking.hostName = "sithy-one";
}