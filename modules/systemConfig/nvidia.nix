{ config, lib, pkgs, ...}:

{
    config = lib.mkIf (config.mySystem.desktop.enable) {
        hardware.graphics = {
            enable = true;
        };

        services.xserver.videoDrivers = ["nvidia"];

        hardware.nvidia = {
            modesetting.enable = true;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            open = false;
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.production;
        };
    };
}
