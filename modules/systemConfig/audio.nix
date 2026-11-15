{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Any host with a display gets audio; headless hosts do not. Gating on
  # laptop.enable meant the desktop only had PipeWire because Plasma 6 pulls it
  # in as a default, and it never got security.rtkit (real-time priority).
  config = lib.mkIf (config.mySystem.environment != null) {
    # Enable sound with pipewire.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };
}
