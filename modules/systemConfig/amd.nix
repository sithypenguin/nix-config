{ config, pkgs, lib, ... }:

{
  config = lib.mkIf (config.mySystem.desktop.enable && config.mySystem.desktop.amd && !config.mySystem.desktop.nvidia) {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.xserver.videoDrivers = [ "amdgpu" ];

    hardware.amdgpu.initrd.enable = true;

    hardware.firmware = [ pkgs.linux-firmware ];

    environment.systemPackages = [pkgs.amdgpu_top];
  };
}