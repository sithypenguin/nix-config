{ config, pkgs, pkgs-unstable, ... }:

{
    home.packages = with pkgs; [
        ncspot      # Cross-platform ncurses Spotify client written in Rust, inspired by ncmpc and the likes
    ]
    
}
       