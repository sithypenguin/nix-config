{ config, pkgs, lib, ... }:

{
  # Bluetooth configuration
  config = lib.mkIf config.mySystem.hardware.bluetooth {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
  };
}