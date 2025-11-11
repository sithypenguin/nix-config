# Basic system configuration module
# Contains fundamental system settings like bootloader, time zone, and locale
{ config, pkgs, ... }:

{
    # Bootloader configuration
    boot.loader.systemd-boot.enable = true;        # Use systemd-boot as the bootloader
    boot.loader.efi.canTouchEfiVariables = true;   # Allow modification of EFI variables
    
    # Nix package manager settings
    nix.settings.experimental-features = [ "nix-command" "flakes" ];  # Enable flakes and new CLI
    
    # System locale and timezone
    time.timeZone = "America/New_York";             # System timezone
    i18n.defaultLocale = "en_US.UTF-8";            # Default system locale
    
    # Additional locale settings for various categories
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";         # Address formatting
        LC_IDENTIFICATION = "en_US.UTF-8";  # Personal name formatting
        LC_MEASUREMENT = "en_US.UTF-8";     # Measurement units
        LC_MONETARY = "en_US.UTF-8";        # Currency and monetary formatting
        LC_NAME = "en_US.UTF-8";            # Personal name formatting
        LC_NUMERIC = "en_US.UTF-8";         # Number formatting
        LC_PAPER = "en_US.UTF-8";           # Paper size standards
        LC_TELEPHONE = "en_US.UTF-8";       # Telephone number formatting
        LC_TIME = "en_US.UTF-8";            # Time and date formatting
    };

    # Package configuration
    nixpkgs.config.allowUnfree = true;              # Allow installation of unfree packages
}