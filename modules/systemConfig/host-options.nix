{ lib, pkgs, config, ... }:

{
    options.mySystem = with lib; {
        # ========== IDENTITY ==========
        primaryUser = mkOption {
            type = types.str;
            default = "sithy";
            description = ''
              The interactive user this host is built for. Used as the default
              for options that need a user (rootless Podman, lingering) so a new
              host does not have to repeat it.
            '';
        };

        # ========== ROLE-LEVEL OPTIONS (System Configuration) ==========
        laptop = {
            enable = mkEnableOption "laptop-specific system configuration";
        };

        desktop = {
            enable = mkEnableOption "desktop-specific system configuration";
        };

        environment = mkOption {
            type = types.nullOr (types.enum [ "hyprland" "plasma6" ]);
            default = null;
            description = ''
              Desktop environment selection. Defaults to null (headless) so a
              host that imports only base.nix cannot silently acquire a display
              manager. Graphical profiles set it explicitly.
            '';
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
            steam = mkEnableOption "Steam";
            gamescope = mkEnableOption "Gamescope nested gaming compositor";
        };

        development = {
            godot = mkEnableOption "Godot from unstable nixpkgs";
            nixLd = mkEnableOption "nix-ld dynamic linker shim for unpatched binaries";
        };

        hardware = {
            bluetooth = mkEnableOption "Bluetooth support";

            gpu = mkOption {
                type = types.nullOr (types.enum [ "amd" "nvidia" "intel" ]);
                default = null;
                description = ''
                  Discrete GPU vendor for driver selection. Independent of role:
                  a headless compute box can set "nvidia" without importing a
                  graphical profile. null = no discrete GPU drivers (integrated
                  graphics work through the kernel's modesetting driver).
                '';
            };

            nvidiaOpen = mkOption {
                type = types.bool;
                default = true;
                description = ''
                  Use NVIDIA's open kernel modules instead of the proprietary
                  ones. Supported on Turing and newer (RTX 20xx+); ignored when
                  hardware.gpu is not "nvidia".
                '';
            };
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
                hermesDesktop = mkEnableOption "Hermes Agent desktop client (from the upstream flake)";
                podmanDesktop = mkEnableOption "Podman Desktop GUI client";
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
            printing = mkEnableOption "CUPS printing and mDNS printer discovery";
            openssh = mkEnableOption "OpenSSH server";

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
                    default = config.mySystem.primaryUser;
                    defaultText = lib.literalExpression "config.mySystem.primaryUser";
                    example = "sithy";
                    description = "User that runs rootless Podman. Gets subuid/subgid ranges, lingering and the user Podman socket. Required when rootless = true.";
                };
                compose = mkOption {
                    type = types.bool;
                    default = true;
                    description = "Install podman-compose for compose-style multi-container stacks.";
                };
            };

        };
    };
}