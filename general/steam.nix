{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.mySystem.gaming.steam {
    programs.steam = {
      enable = true;
    };
  };
}