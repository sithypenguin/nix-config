{ ... }:

{
    imports = [
        ./systemConfig/fonts.nix
        ./systemConfig/amd.nix
        ./systemConfig/audio.nix
        ./systemConfig/bluetooth.nix
        ./systemConfig/display.nix
        ./systemConfig/docker.nix
        ./systemConfig/host-options.nix
        ./systemConfig/nix-ld.nix
        ./systemConfig/networking.nix
        ./systemConfig/nvidia.nix
        ./systemConfig/ollama.nix
        ./systemConfig/sysConfig.nix
        ./systemConfig/tailscale.nix
        ./systemConfig/zsh.nix
        ./systemConfig/hyprland.nix
        ./hyprland/cachix.nix
        ./gaming/steam.nix
        ../users/users.nix
        
    ];
}