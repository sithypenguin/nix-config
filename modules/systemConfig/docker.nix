{ config, lib, pkgs, ...}:

{
    config = lib.mkIf (config.mySystem.desktop.enable && config.mySystem.development.docker) {
        virtualisation.docker.enable = true;
        virtualisation.docker.storageDriver = "btrfs";
    };
}