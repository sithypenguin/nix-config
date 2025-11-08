# GUI Applications package list
# Desktop applications and productivity tools for the user environment
{ config, pkgs, pkgs-unstable, ... }:

{
    # User GUI applications installed via Home Manager
    home.packages = with pkgs; [
        # Development and Text Editing
        vscode                # Open source source code editor developed by Microsoft for Windows, Linux and macOS
        
        # Security and Privacy
        bitwarden-desktop     # Secure and free password manager for all of your devices
        
        # Media and Entertainment
        vlc                   # Cross-platform media player and streaming server
        spotify               # Play music from the Spotify music service

        # Communication
        discord               # All-in-one cross-platform voice and text chat for gamers
        telegram-desktop      # Telegram Desktop messaging app
        
        # Productivity and Office
        libreoffice          # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
        obsidian             # A powerful knowledge base that works on top of a local folder of plain text Markdown files
        drawio               # A desktop application for creating diagrams
        
        # Web Browsing
        firefox              # Web browser built from Firefox source tree

        # 3D Printing
        pkgs-unstable.prusa-slicer         # G-code generator for 3D printer
    ];
}