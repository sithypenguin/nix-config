{ ... }:

# sithy-top — desktop. Role policy comes from modules/profiles/desktop.nix,
# selected in flake.nix. Only what is specific to THIS machine lives here.

{
    imports = [ ./hardware-configuration.nix ];

    mySystem = {
        hardware.gpu = "amd";

        services.ollama.enable = true;
        gaming.gamescope = true;

        # Podman is enabled for local container management via Podman Desktop.
        # services.podman.user defaults to mySystem.primaryUser, so it is not
        # repeated here.
        services.podman.enable = true;
    };

    networking.hostName = "sithy-top";
}
