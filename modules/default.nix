{ ... }:

{
    imports = [
        ./systemConfig/fonts.nix
        ./systemConfig/amd.nix
        ./systemConfig/audio.nix
        ./systemConfig/bluetooth.nix
        ./systemConfig/display.nix
        ./systemConfig/host-options.nix
        ./systemConfig/intel.nix
        ./systemConfig/nix-ld.nix
        ./systemConfig/networking.nix
        ./systemConfig/nvidia.nix
        ./systemConfig/ollama.nix
        ./systemConfig/openssh.nix
        ./systemConfig/sysConfig.nix
        ./systemConfig/tailscale.nix
        ./systemConfig/zsh.nix
        ./systemConfig/hyprland.nix
        ./hyprland/cachix.nix
        ./gaming/steam.nix
        ./gaming/gamescope.nix
        ./services/podman.nix
        ../users/users.nix
        
    ];
}