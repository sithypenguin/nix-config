# Steam as a user-level package (Home Manager)
{ config, pkgs, pkgs-unstable, ... }:
{
  # Note: System module `programs.steam.enable` provides 32-bit runtime and drivers.
  # Installing the package via HM is convenient for user-level control, but may
  # require system-level support depending on GPU/setup.
  home.packages = with pkgs; [
    steam
  ];
}
