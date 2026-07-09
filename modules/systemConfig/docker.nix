{ config, lib, pkgs, ...}:

{
    config = lib.mkIf (config.mySystem.desktop.enable && config.mySystem.desktop.docker) {
        virtualization.docker.enable = true;
}