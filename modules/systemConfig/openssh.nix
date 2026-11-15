{ config, lib, ... }:

# OpenSSH server. Gated on mySystem.services.openssh so it is opt-in per host
# rather than global; the server profile turns it on by default.

{
    config = lib.mkIf config.mySystem.services.openssh {
        services.openssh = {
            enable = true;
            settings = {
                PasswordAuthentication = false;
                KbdInteractiveAuthentication = false;
                PermitRootLogin = "no";
            };
        };
    };
}
