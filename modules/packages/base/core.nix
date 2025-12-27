{ config, pkgs, pkgs-unstable, ... }:
{
    home.packages = with pkgs; [
        git
        bat
        zellij
        fastfetch
        kitty
        zsh
    ] ++ [
        pkgs-unstable.ghostty
    ];
}