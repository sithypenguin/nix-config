{ lib, ... }:

{
    options.mySystem = with lib; {
        laptop = {
            enable = mkEnableOption "laptop environment";
            environment = mkOption {
                type = types.enum [ "plasma6" "gnome" "hyprland" ];
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
        };

        hardware = {
            bluetooth = mkEnableOption "Bluetooth support";
        };

    };
}