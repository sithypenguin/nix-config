# Home Manager configuration for user 'sithy'
# This file manages user-specific packages and configurations
{ config, pkgs, ... }:

{
    # Import user-specific package and configuration modules
    imports = [
        ../../general/sys-util-packages.nix  # System utility packages
        ../../general/gui-packages.nix       # GUI packages
    ];

    # Allow unfree packages for Home Manager
    nixpkgs.config.allowUnfree = true;
    
    # User account settings
    home.username = "sithy";
    home.homeDirectory = "/home/sithy";
    
    # Home Manager version - should match your NixOS version
    home.stateVersion = "25.05";
}

