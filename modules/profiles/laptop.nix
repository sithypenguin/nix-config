{ pkgs, ... }:

{
    mySystem = {
        laptop.enable = true;
        laptop.environment = "plasma6";
        #laptop.environment = "hyprland";
        gaming.enable = true;
        gaming.steam = true;
        development.enable = true;
        hardware.bluetooth = true;
        shell.zsh = true;
    };

    environment.systemPackages = with pkgs; [
        lm_sensors
    ];
}
