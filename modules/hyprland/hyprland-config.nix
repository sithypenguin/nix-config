{ config, pkgs, ... }:

{
  # Hyprland configuration files
  home.file.".config/hypr/hyprland.conf".source = ../../dotfiles/hyprland/hypr/hyprland.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ../../dotfiles/hyprland/hypr/hyprpaper.conf;
  home.file.".config/hypr/hyprlock.conf".source = ../../dotfiles/hyprland/hypr/hyprlock.conf;
  home.file.".config/hypr/infonlock.sh".source = ../../dotfiles/hyprland/scripts/infonlock.sh;
  
  # Waybar configuration files
  home.file.".config/waybar/config.json".source = ../../dotfiles/hyprland/waybar/config.json;
  home.file.".config/waybar/style.css".source = ../../dotfiles/hyprland/waybar/style.css;
  
  # Mako configuration
  home.file.".config/mako/config".source = ../../dotfiles/hyprland/mako/config;
  
  # Rofi configuration
  home.file.".config/rofi/config.rasi".source = ../../dotfiles/hyprland/rofi/config.rasi;
}