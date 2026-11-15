{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf (config.mySystem.hardware.gpu == "amd") {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.xserver.videoDrivers = [ "amdgpu" ];

    hardware.amdgpu.initrd.enable = true;

    hardware.firmware = [ pkgs.linux-firmware ];

    environment.systemPackages = [ pkgs.amdgpu_top ];
  };
}
