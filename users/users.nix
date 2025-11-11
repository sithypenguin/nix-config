{ config, pkgs, ... }:

{
    users.users.sithy = {
        isNormalUser = true;
        description = "SithyPenguin";
        extraGroups = [ "networkmanager" "wheel" ];
  };
}