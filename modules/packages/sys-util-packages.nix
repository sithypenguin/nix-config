# System Utilities package list
# Command-line tools and system utilities for development and system administration
{ config, pkgs, ... }:

{
    # User system utility packages installed via Home Manager
    home.packages = with pkgs; [
        # Version Control and Development
        git                  # Distributed version control system
        direnv              # Shell extension that manages your environment
        
        # Terminal and Session Management
        zellij              # A terminal workspace with batteries included
        ghostty             # Fast, native, feature-rich terminal emulator pushing modern features
        
        # System Information and Monitoring
        fastfetch           # Like neofetch but faster because written in C
        btop                # A monitor of resources
        bmon                # Network bandwidth monitor
        clinfo              # Print all known information about all available OpenCL platforms and devices in the system
        isd                 # TUI to interactively work with systemd units
        s-tui               # Stress-Terminal UI monitoring tool
        brightnessctl       # This program allows you read and control device brightness
        
        # Network Tools
        nettools            # A set of tools for controlling the network subsystem in Linux
        dig                 # Domain name server lookup utility
        bluetui             # TUI for managing bluetooth on Linux
        
        # File and Disk Management
        ncdu                # Disk usage analyzer with an ncurses interface
        duf                 # Disk Usage/Free Utility
        bat                 # Cat(1) clone with syntax highlighting and Git integration
        superfile           # Blazing fast terminal file manager written in Rust, based on async I/O
        
        # Documentation and Help
        tlrc                # Official tldr client written in Rust
        vhs                 #Tool for generating terminal GIFs with code

        gnome-keyring        # GNOME application for managing passwords and encryption keys
        seahorse             # GNOME application for managing encryption keys and passwords

    ];
}