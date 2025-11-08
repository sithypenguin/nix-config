{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../profiles/desktop.nix
    ];

    networking.hostName = "sithy-one";
}