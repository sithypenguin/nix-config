{ config, lib, ... }:

# Intel integrated graphics. Selected by mySystem.hardware.gpu = "intel" on any
# host, graphical or headless.
#
# No services.xserver.videoDrivers entry: Intel needs no out-of-tree driver, the
# kernel's i915/xe module handles it and modesetting is already the default.
# enable32Bit matters for Steam/Proton on these machines.

{
  config = lib.mkIf (config.mySystem.hardware.gpu == "intel") {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
