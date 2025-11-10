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
        ./packages/gui-packages.nix
        ./packages/sys-util-packages.nix
        ./packages/tui-packages.nix
        ./gaming/steam.nix
        ./users/users.nix
    ];
}