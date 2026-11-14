{ pkgs, lib, ... }:

# System-wide fonts.
#
# These land in /run/current-system/sw/share/fonts and are visible to every
# user and every application through fontconfig — no Home Manager needed.
#
# The defaultFonts block is what makes the config actually *use* them. Without
# it, fontconfig still resolves `monospace` to whatever nixpkgs lists first
# (Hack, on this system), so a terminal asking for "monospace" would not get
# Fira Code. Setting the aliases means anything that requests the generic
# families gets the fonts declared here.
#
# Applications that name a family explicitly (kitty, waybar, rofi, mako all ask
# for "FiraCode Nerd Font Mono") resolve through the same fontconfig database,
# so they pick these up automatically.

{
  fonts = {
    packages = with pkgs; [
      fira-code
      fira-sans
      nerd-fonts.fira-code
      font-awesome
      jetbrains-mono
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        monospace = [ "FiraCode Nerd Font Mono" "JetBrains Mono" ];
        sansSerif = [ "Fira Sans" ];
        serif = [ "Fira Sans" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
