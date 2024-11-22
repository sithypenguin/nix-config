{ config, pkgs, ...}:

{
    environment.systemPackages = with pkgs; [

        # CLI Apps
        # Package name                          #Package Description
        git

        # GUI Apps
        telegram-desktop
    ];
}
