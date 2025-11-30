{ config, pkgs, pkgs-unstable, ... }:

{
    home.packages = with pkgs; [
        ncspot      # Cross-platform ncurses Spotify client written in Rust, inspired by ncmpc and the likes
        bluetui     # TUI for managing bluetooth on Linux
        isd         # TUI to interactively work with systemd units
        s-tui       # Stress-Terminal UI monitoring tool
    ];
}