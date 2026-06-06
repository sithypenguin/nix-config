{ lib, pkgs, ... }:

{
    options.mySystem = with lib; {
        laptop = {
            enable = mkEnableOption "laptop environment";
            environment = mkOption {
                type = types.enum [ "plasma6" "hyprland" ];
                default = "plasma6";
                description = "Laptop environment to use";
            };
        };

        gaming = {
            enable = mkEnableOption "gaming environment";
            steam = mkEnableOption "Steam";
        };

        development = {
            enable = mkEnableOption "development tools";
            godot = mkEnableOption "Godot from unstable nixpkgs";
        };

        hardware = {
            bluetooth = mkEnableOption "Bluetooth support";
        };

        shell = {
            zsh = mkEnableOption "Zsh shell";
        };

        desktop = {
            enable = mkEnableOption "desktop environment";
            environment = mkOption {
                type = types.enum [ "plasma6" "hyprland" ];
                default = "plasma6";
                description = "Desktop environment to use";
            };
            amd = mkEnableOption "AMD GPU drivers";
            nvidia = mkEnableOption "Nvidia drivers";
        };

        cursor = {
            enable = mkEnableOption "cursor theme setup";
            package = mkOption {
                type = types.package;
                default = pkgs.bibata-cursors;
                description = "Cursor theme package";
            };
            name = mkOption {
                type = types.str;
                default = "Bibata-Modern-Classic";
                description = "Cursor theme name for GTK/Hyprland";
            };
            size = mkOption {
                type = types.int;
                default = 24;
                description = "Cursor size";
            };
        };

    };
}