{ config, pkgs, ... }:

{
  # Create the Kvantum theme directory and files
  home.file.".config/Kvantum/SolarSystem/SolarSystem.kvconfig".source = 
    ../../dotfiles/kvantum/SolarSystem/SolarSystem.kvconfig;
  
  home.file.".config/Kvantum/SolarSystem/SolarSystem.svg".source = 
    ../../dotfiles/kvantum/SolarSystem/SolarSystem.svg;
  
  # Set Kvantum to use this theme
  home.file.".config/Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=SolarSystem
  '';
}