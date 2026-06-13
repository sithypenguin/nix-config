{ lib, ... }:

{
    options.mySystem = with lib; {
        # ========== ROLE-LEVEL OPTIONS (System Configuration) ==========
        laptop = {
            enable = mkEnableOption "laptop-specific system configuration";
            environment = mkOption {
                type = types.enum [ "plasma6" "hyprland" ];
                default = "plasma6";
                description = "Laptop environment to use";
            };
        };

        desktop = {
            enable = mkEnableOption "desktop-specific system configuration";
            environment = mkOption {
                type = types.enum [ "plasma6" "hyprland" ];
                default = "plasma6";
                description = "Desktop environment to use";
            };
            amd = mkEnableOption "AMD GPU drivers";
            nvidia = mkEnableOption "Nvidia drivers";
        };

        # ========== SYSTEM-LEVEL FEATURES ==========
        gaming = {
            enable = mkEnableOption "gaming environment";
            steam = mkEnableOption "Steam";
        };

        development = {
            enable = mkEnableOption "development tools";
            godot = mkEnableOption "Godot from unstable nixpkgs";
        };

        hardware = {
            bluetooth = mkEnableOption "Bluetooth support";
        };

        shell = {
            zsh = mkEnableOption "Zsh shell";
        };

        # ========== USER-LEVEL PACKAGE CATEGORIES ==========
        # Structure: mySystem.packages.<category>.<subcategory>.enable
        # These options control which Home Manager package modules are included
        packages = {
            base = {
                core = mkEnableOption "base core packages (git, kitty, zsh, bat)";
                cliTools = mkEnableOption "CLI utility packages (htop, ncdu, btop)";
                devTools = mkEnableOption "development tools (direnv, pkg-config)";
            };

            network = {
                base = mkEnableOption "network diagnostics (clinfo, dnsutils)";
                wireless = mkEnableOption "wireless tools (networkmanagerapplet)";
                bluetooth = mkEnableOption "Bluetooth tools (bluetui)";
            };

            gui = {
                base = mkEnableOption "core GUI apps (firefox, vscode)";
                multimedia = mkEnableOption "multimedia packages (vlc, spotify)";
                office = mkEnableOption "office tools (libreoffice, obsidian)";
                comms = mkEnableOption "communication apps (discord, telegram)";
                design = mkEnableOption "design software (prusa-slicer)";
                tui = mkEnableOption "terminal UI apps (ncspot)";
            };

            gaming = {
                steam = mkEnableOption "Steam (user-level package)";
            };

            development = {
                godot = mkEnableOption "Godot game engine (from unstable)";
            };
        };

        # ========== DESKTOP ENVIRONMENT PACKAGES ==========
        # Control which DE-specific package modules are imported
        # These are separate from role-based selection to allow mixing DEs on same host
        desktopEnvironments = {
            hyprland = mkEnableOption "Hyprland window manager packages and dotfiles";
            plasma6 = mkEnableOption "Plasma6 desktop environment";
        };

        laptopEnvironments = {
            hyprland = mkEnableOption "Hyprland window manager for laptop";
            plasma6 = mkEnableOption "Plasma6 desktop environment for laptop";
        };

        # ========== SERVICES (Future-Proofing for Ollama, etc.) ==========
        services = {
            ollama = {
                enable = mkEnableOption "Ollama LLM service (placeholder for future)";
                port = mkOption {
                    type = types.int;
                    default = 11434;
                    description = "Port for Ollama service";
                };
            };
        };

    };
}