{ config, pkgs, ... }:

{
  # Hyprland binary cache, so Hyprland and its deps come prebuilt instead of
  # compiling from source.
  #
  # extra-substituters / extra-trusted-public-keys APPEND to the list. The
  # plain `substituters` key REPLACES it, which would silently drop
  # cache.nixos.org and any cache another module adds later.
  nix.settings = {
    extra-substituters = [
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
