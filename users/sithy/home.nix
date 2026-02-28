# Home Manager configuration for user 'sithy'
# This file manages user-specific packages and configurations
{ lib, pkgs, pkgs-unstable, mySystem, hostname, ... }:

let
  # Category modules grouped by purpose; each is a Home Manager module
  profiles = {
    base = {
      core      = import ../../modules/packages/base/core.nix;
      cliTools  = import ../../modules/packages/base/cli-tools.nix;
      devTools  = import ../../modules/packages/base/dev-tools.nix;
      # Fonts are system-wide; managed under modules/systemConfig/fonts.nix
    };
    network = {
      base      = import ../../modules/packages/network/base.nix;
      wireless  = import ../../modules/packages/network/wireless.nix;
      bluetooth = import ../../modules/packages/network/bluetooth.nix;
    };
    gui = {
      base         = import ../../modules/packages/gui/base.nix;
      multimedia   = import ../../modules/packages/gui/multimedia.nix;
      office       = import ../../modules/packages/gui/office.nix;
      comms        = import ../../modules/packages/gui/comms.nix;
      design       = import ../../modules/packages/gui/design.nix;
      tui          = import ../../modules/packages/gui/tui.nix;
    };
    gaming = {
      steam       = import ../../modules/packages/gaming/steam.nix;
    };
  };

  # Host-driven profile selection; adjust lists per host as needed
  enabledProfilesByHost = {
    "sithy-one" = [
      "base.core" "base.cliTools" "base.devTools"
      "network.base" "network.wireless" "network.bluetooth"
      "gui.base" "gui.multimedia" "gui.office" "gui.comms" "gui.design" "gui.tui"
    ];
    "sithy-top" = [
      "base.core" "base.cliTools" "base.devTools"
      "network.base" "network.wireless" "network.bluetooth"
      "gui.base" "gui.multimedia" "gui.office" "gui.comms" "gui.design" "gui.tui"
      "gaming.steam"
    ];
  };

  # Resolve string path like "gui.base" → profiles.gui.base
  getProfile = path:
    let parts = lib.splitString "." path;
    in lib.attrByPath parts (throw "Unknown profile path: ${path}") profiles;

  enabled = lib.attrByPath [ hostname ] [] enabledProfilesByHost;

  # Desktop environment-specific user modules (Hyprland user apps + dotfiles only on sithy-one)
  envModules =
    (lib.optionals (hostname == "sithy-one") [
      ../../modules/hyprland/hyprland.nix
      ../../modules/hyprland/hyprland-config.nix
    ]);

in {
  imports =
    # Host-chosen package categories
    (map getProfile enabled)
    # DE-specific user modules
    ++ envModules;

  # Allow unfree packages for Home Manager
  nixpkgs.config.allowUnfree = true;

  # User account settings
  home.username = "sithy";
  home.homeDirectory = "/home/sithy";

  # Home Manager version - should match your NixOS version
  home.stateVersion = "25.05";

  xdg.desktopEntries."PrusaSlicer" = {
  name = "PrusaSlicer";
  genericName = "3D Printing Software";
  # The --single-instance flag is the key here
  exec = "env DESKTOP_PORTAL_ID=PrusaSlicer prusa-slicer --single-instance %U";
  icon = "PrusaSlicer";
  terminal = false;
  categories = [ "Graphics" "3DGraphics" "Engineering" ];
  mimeType = [ 
    "model/stl" 
    "model/3mf" 
    "x-scheme-handler/prusaslicer" 
  ];
  settings = {
    StartupWMClass = "prusa-slicer";
  };
};
  # XDG MIME type associations
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/prusaslicer" = [ "org.kde.klipper.desktop" ];
  };

  home.preferXdgDirectories = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
};

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      eval "$(direnv hook zsh)"
    '';

    shellAliases = {
      cdfh = "cd ~/Development/nix-dev/nix-config";
      nix-flake-test = "sudo nixos-rebuild test --flake .#$HOSTNAME";
      nix-flake-switch = "sudo nixos-rebuild switch --flake .#$HOSTNAME";
    };

    oh-my-zsh = {
      enable = true;
      theme = "linuxonly";  # Set the Oh My Zsh theme to 'linuxonly'
      plugins = [ "git" "sudo" "direnv" ];  # List of Oh My Zsh plugins to enable
    };
  };
}

