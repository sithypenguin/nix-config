# Network and connectivity configuration
# Manages network interfaces, hostname, and Bluetooth settings
{ config, pkgs, ... }:

{
    # Bluetooth configuration
    hardware.bluetooth.enable = true;               # Enable Bluetooth support
    
    # Network configuration
    networking.networkmanager.enable = true;       # Enable NetworkManager for network management
}