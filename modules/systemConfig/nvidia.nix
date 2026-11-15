{ config, lib, pkgs, ...}:

{
    config = lib.mkIf (config.mySystem.hardware.gpu == "nvidia") {
        hardware.graphics = {
            enable = true;
        };

        services.xserver.videoDrivers = ["nvidia"];

        hardware.nvidia = {
            modesetting.enable = true;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            open = config.mySystem.hardware.nvidiaOpen;
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.production;
        };
    };
}
