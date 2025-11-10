# Home Manager configuration for user 'sithy'
# This file manages user-specific packages and configurations
{ config, pkgs, ... }:

{
    # Import user-specific package and configuration modules
    imports = [
        ../../packages/sys-util-packages.nix  # System utility packages
        ../../packages/gui-packages.nix       # GUI packages
        ../../packages/tui-packages.nix       # TUI packages
    ];

    # Allow unfree packages for Home Manager
    nixpkgs.config.allowUnfree = true;
    
    # User account settings
    home.username = "sithy";
    home.homeDirectory = "/home/sithy";
    
    # Home Manager version - should match your NixOS version
    home.stateVersion = "25.05";
}

