{ pkgs, ... }:

{
    fonts.packages = with pkgs; [
        fira-code
        nerd-fonts.fira-code
        font-awesome
        jetbrains-mono
    ];
}