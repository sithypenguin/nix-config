{ config, lib, ... }:
{
  config = lib.mkIf config.mySystem.gaming.gamescope {
    programs.gamescope.enable = true;
  };
}