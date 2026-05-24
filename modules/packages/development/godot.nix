{ lib, pkgs-unstable, mySystem, ... }:
{
  home.packages = lib.optionals mySystem.development.godot [
    pkgs-unstable.godot
  ];
}
