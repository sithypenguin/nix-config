{ config, pkgs, ... }:

{
  # Hyprland configuration files
  home.file.".config/hypr/hyprland.conf".source = ../../dotfiles/hyprland/hypr/hyprland.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ../../dotfiles/hyprland/hypr/hyprpaper.conf;
  home.file.".config/hypr/hyprlock.conf".source = ../../dotfiles/hyprland/hypr/hyprlock.conf;
  home.file.".config/hypr/hypridle.conf".source = ../../dotfiles/hyprland/hypr/hypridle.conf;

  # Hyprpaper picture files
  home.file.".config/hypr/wallpapers/oled-solar-system.png".source = ../../assets/background-pictures/oled-solar-system.png;
  
  # Waybar configuration
  home.file.".config/waybar/config.json".source = ../../dotfiles/hyprland/waybar/config.json;
  home.file.".config/waybar/style.css".source = ../../dotfiles/hyprland/waybar/style.css;
  
  # Wlogout configuration
  home.file.".config/wlogout/layout".source = ../../dotfiles/hyprland/wlogout/layout;
  home.file.".config/wlogout/style.css".source = ../../dotfiles/hyprland/wlogout/style.css;
  # Wlogout icons copied into the config directory for portable paths
  home.file.".config/wlogout/icons" = {
    source = ../../assets/wlogout;
    recursive = true;
  };
  
  # Mako configuration
  home.file.".config/mako/config".source = ../../dotfiles/hyprland/mako/config;
  
  # Rofi configuration
  home.file.".config/rofi/config.rasi".source = ../../dotfiles/hyprland/rofi/config.rasi;
  
  # Kitty configuration
  home.file.".config/kitty/kitty.conf".source = ../../dotfiles/hyprland/kitty/kitty.conf;
}