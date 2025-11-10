{ pkgs, ... }:

{
    fonts.packaages = with pkgs; [
        firacode
        nerd-fonts.fira-code
        font-awesome
        jetbrains-mono
    ];
}