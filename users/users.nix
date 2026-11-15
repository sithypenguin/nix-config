{ config, lib, ... }:

# The interactive account. Name comes from mySystem.primaryUser so a host can
# change it in one place (and flake.nix's mkHost username must match).

{
    users.users.${config.mySystem.primaryUser} = {
        isNormalUser = true;
        description = "SithyPenguin";
        extraGroups = [ "networkmanager" "wheel" ];
    };
}
