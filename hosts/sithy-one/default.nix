{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../system/sysConfig.nix
        ../../system/audio.nix
        ../../system/display.nix
        ../../system/users.nix
        ../../general/steam.nix
        ../../system/connectivity.nix
    ];

    networking.hostName = "sithy-one";
}