{ lib, ... }:

{
    options.mySystem = with lib; {
        desktop = {
            enable = mkEnableOption "laptop envirnonment";
            envirnonment = mkOption {
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

    }
}