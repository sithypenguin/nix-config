{ config, pkgs, pkgs-unstable, lib, ...}:

{
    config = lib.mkIf (config.mySystem.environment == "hyprland") {
        programs.hyprland = {
            enable = true;
            package = pkgs-unstable.hyprland;
        };
    };
}