{ lib, pkgs, ... }:

{
    options.mySystem = with lib; {
        # ========== ROLE-LEVEL OPTIONS (System Configuration) ==========
        laptop = {
            enable = mkEnableOption "laptop-specific system configuration";
        };

        desktop = {
            enable = mkEnableOption "desktop-specific system configuration";
            amd = mkEnableOption "AMD GPU drivers";
            nvidia = mkEnableOption "Nvidia drivers";
        };

        environment = mkOption {
            type = types.nullOr (types.enum [ "hyprland" "plasma6" ]);
            default = "plasma6";
            description = "Desktop environment selection. Use null explicitly for headless servers.";
        };

        cursor = {
                enable = mkEnableOption "cursor theme setup";
                package = mkOption {
                    type = types.package;
                    default = pkgs.bibata-cursors;
                    description = "Cursor theme package";
                };
                name = mkOption {
                    type = types.str;
                    default = "Bibata-Modern-Classic";
                    description = "Cursor theme name for GTK/Hyprland";
                };
                size = mkOption {
                    type = types.int;
                    default = 24;
                    description = "Cursor size";
                };
            };

        # ========== SYSTEM-LEVEL FEATURES ==========
        gaming = {
            enable = mkEnableOption "gaming environment";
            steam = mkEnableOption "Steam";
            gamescope = mkEnableOption "Gamescope nested gaming compositor";
        };

        development = {
            enable = mkEnableOption "development tools";
            godot = mkEnableOption "Godot from unstable nixpkgs";
            docker = mkEnableOption "Enable docker engine";
            nixLd = mkEnableOption "nix-ld dynamic linker shim for unpatched binaries";
        };

        hardware = {
            bluetooth = mkEnableOption "Bluetooth support";
        };

        shell = {
            zsh = mkEnableOption "Zsh shell";
        };

        networking = {
            tailscale =mkEnableOption "Tailscale client";
        };

        # ========== USER-LEVEL PACKAGE CATEGORIES ==========
        # Structure: mySystem.packages.<category>.<subcategory>.enable
        # These options control which Home Manager package modules are included
        packages = {
            base = {
                core = mkEnableOption "base core packages (git, kitty, zsh, bat)";
                cliTools = mkEnableOption "CLI utility packages (htop, ncdu, btop)";
                devTools = mkEnableOption "development tools (direnv, pkg-config, .NET SDK 10.0)";
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
                nomachine = mkEnableOption "NoMachine client package";
            };

            gaming = {
                steam = mkEnableOption "Steam (user-level package)";
            };

            development = {
                godot = mkEnableOption "Godot game engine (from unstable)";
            };
        };

        # ========== SERVICES ==========
        services = {
            ollama = {
                enable = mkEnableOption "Ollama LLM service";
                port = mkOption {
                    type = types.int;
                    default = 11434;
                    description = "Port for Ollama service";
                };
            };

            podman = {
                enable = mkEnableOption "Podman container engine";
                rootless = mkOption {
                    type = types.bool;
                    default = true;
                    description = "Run Podman rootless as `user` (least privilege). Set to false to use the system-wide (rootful) Podman socket instead.";
                };
                user = mkOption {
                    type = types.str;
                    default = "";
                    example = "sithy";
                    description = "User that runs rootless Podman. Gets subuid/subgid ranges, lingering and the user Podman socket. Required when rootless = true.";
                };
                dockerCompat = mkOption {
                    type = types.bool;
                    default = false;
                    description = "Provide a `docker` CLI alias for Podman. Conflicts with the Docker engine (mySystem.development.docker).";
                };
                compose = mkOption {
                    type = types.bool;
                    default = true;
                    description = "Install podman-compose for docker-compose style multi-container stacks.";
                };
            };

            cockpit = {
                enable = mkEnableOption "Cockpit web management UI";
                port = mkOption {
                    type = types.port;
                    default = 9090;
                    description = "Port for the Cockpit web UI";
                };
                openFirewall = mkOption {
                    type = types.bool;
                    default = true;
                    description = "Open the Cockpit port in the firewall so the web UI is reachable over the network.";
                };
            };
        };
    };
}