{ ... }:

{
    imports = [
        ./systemConfig/fonts.nix
        ./systemConfig/audio.nix
        ./systemConfig/bluetooth.nix
        ./systemConfig/display.nix
        ./systemConfig/host-options.nix
        ./systemConfig/networking.nix
        ./systemConfig/sysConfig.nix
        ./systemConfig/zsh.nix
        ./systemConfig/hyprland.nix
        ./systemConfig/printing.nix
        ./hyprland/cachix.nix
        ./gaming/steam.nix
        ../users/users.nix
        
    ];
}