{ config, pkgs, pkgs-unstable, ...}:

{
    programs.hyprland = {
        enable = true;
        package = pkgs-unstable.hyprland;
    };
}