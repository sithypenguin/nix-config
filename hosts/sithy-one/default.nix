{ ... }:

# sithy-one — laptop. Role policy comes from modules/profiles/laptop.nix,
# selected in flake.nix. Only what is specific to THIS machine lives here.

{
    imports = [ ./hardware-configuration.nix ];

    mySystem = {
        # Integrated Radeon in the Raphael APU; no discrete GPU drivers needed.
        hardware.gpu = null;
    };

    networking.hostName = "sithy-one";
}
