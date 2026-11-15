{ config, lib, ... }:

# The interactive account. Name comes from mySystem.primaryUser so a host can
# change it in one place (and flake.nix's mkHost username must match).

{
    users.users.${config.mySystem.primaryUser} = {
        isNormalUser = true;
        description = "SithyPenguin";
        # networkmanager only when the service is enabled: the group does not
        # exist otherwise, and a host without NetworkManager would carry a
        # dangling group reference.
        extraGroups = [ "wheel" ]
            ++ lib.optional config.mySystem.networking.networkmanager "networkmanager";
    };
}
