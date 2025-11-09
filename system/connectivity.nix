{ config, pkgs, lib, ... }:

{
  # Enable networking
  #networking.networkmanager.enable = true;

  # Bluetooth configuration
  config = lib.mkIf config.mySystem.hardware.bluetooth {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
  };
}