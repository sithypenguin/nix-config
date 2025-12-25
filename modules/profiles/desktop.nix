{ pkgs, ... }:

{
    mySystem = {
        desktop.enable = true;
        desktop.environment = "plasma6";
        #desktop.environment = "hyprland";
        desktop.nvidia = true;
        gaming.enable = true;
        gaming.steam = true;
        development.enable = true;
        shell.zsh = true;
    };

    environment.systemPackages = with pkgs; [
        lm_sensors
    ];
}