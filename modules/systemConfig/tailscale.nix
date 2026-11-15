{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Gated on the option alone. The old desktop.enable conjunct meant setting
  # networking.tailscale on a laptop or server silently did nothing, while
  # packages/network/base.nix still installed the CLI on every host.
  config = lib.mkIf config.mySystem.networking.tailscale {
    services.tailscale.enable = true;
  };
}
