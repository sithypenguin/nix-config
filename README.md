# NixOS Configuration

Multi-host NixOS configuration using flakes with Home Manager integration for user-level package management and declarative dotfile management for Hyprland.

## Quick Start: From Zero to This Exact Setup

1. **Install NixOS** with any basic configuration
2. **Clone this repository:**
   ```bash
   git clone https://github.com/sithypenguin/nix-config.git ~/Development/nix-dev/nix-config
   cd ~/Development/nix-dev/nix-config
   ```
3. **Apply the configuration for your host:**
   ```bash
   sudo nixos-rebuild switch --flake .#sithy-one
   # or
   sudo nixos-rebuild switch --flake .#sithy-top
   ```
4. **Log out and select your desktop environment** from your display manager
5. **Done!** Everything is configured exactly as shown in this repo

## Available Hosts

- **sithy-one** - Laptop with Hyprland window manager, user packages via Home Manager
- **sithy-top** - Desktop with Plasma6 desktop environment, Steam, user packages via Home Manager

## Features

- ✅ **Declarative system configuration** with NixOS flakes
- ✅ **Home Manager integration** for user-level package management
- ✅ **Host-driven package selection** - Each host has its own enabled package categories
- ✅ **Dotfile management** - Hyprland configs version-controlled and symlinked to `~/.config/`
- ✅ **Multiple desktop environments** - Plasma6 (sithy-top) and Hyprland (sithy-one)
- ✅ **Minimal system packages** - Maximize packages at user level (HM) for easier management
- ✅ **Fully reproducible** - Pull this repo and rebuild on any machine

## Architecture & Design

### Key Principles

1. **Host-Driven Configuration**: Each host specifies which NixOS modules and Home Manager package categories it needs via `hostname`
2. **Home Manager First**: User packages are managed via Home Manager; system-level packages reserved for drivers, services, and core system tools
3. **Category-Based Packages**: Packages organized by purpose (base, network, gui, gaming) and imported per-host via `enabledProfilesByHost`
4. **Declarative Dotfiles**: Hyprland configuration files in `dotfiles/hyprland/` are symlinked and managed by Home Manager

### Configuration Flow

```
sudo nixos-rebuild switch --flake .#sithy-one
         ↓
    flake.nix
    ├─ mkHost { hostname = "sithy-one"; }
    │  ├─ configuration.nix
    │  │  ├─ modules/default.nix
    │  │  │  ├─ modules/systemConfig/*  (system services, audio, display, etc.)
    │  │  │  ├─ modules/gaming/steam.nix (conditional)
    │  │  │  └─ users/users.nix
    │  │  └─
    │  ├─ hosts/sithy-one/default.nix
    │  │  ├─ hardware-configuration.nix  (auto-generated)
    │  │  └─ modules/profiles/laptop.nix (sets mySystem options)
    │  │
    │  └─ Home Manager Integration
    │     └─ users/sithy/home.nix
    │        ├─ Host-driven package selection via enabledProfilesByHost
    │        ├─ modules/packages/base/*
    │        ├─ modules/packages/network/*
    │        ├─ modules/packages/gui/*
    │        ├─ modules/packages/gaming/*
    │        ├─ modules/hyprland/* (sithy-one only)
    │        └─ modules/hyprland/hyprland-config.nix (symlinks dotfiles)
    │
    └─ Result: Fully configured, reproducible system
```

### Home Manager vs. System-Level Split

#### System-Level (modules/systemConfig/, modules/gaming/)
- **Services & Daemons**: PipeWire, NetworkManager, Bluetooth, Hyprland
- **Display**: Plasma6/SDDM, Hyprland, display configuration
- **Drivers & Firmware**: GPU drivers (NVIDIA), hardware support, kernel modules
- **Fonts**: System-wide fonts (FiraCode Nerd, JetBrains Mono, Font Awesome)
- **Core Tools**: Essential CLI tools needed by system or root

#### Home Manager (modules/packages/)
- **User Packages**: All user-facing applications and development tools
- **GUI Applications**: Firefox, VSCode, Discord, VLC, etc.
- **Development**: git, direnv, language tools (if needed)
- **Utilities**: CLI tools, TUI apps, terminal emulators
- **Gaming**: Steam (user-level app; GPU drivers at system-level)
- **Dotfiles**: Hyprland config symlinks via `home.file`

This split ensures:
- Minimal system state (easier to debug, audit)
- Fast Home Manager updates (no system rebuild needed for app changes)
- Clear separation of concerns
- Each user can have different package sets

### Host-Driven Package Selection

Each host in [users/sithy/home.nix](users/sithy/home.nix) specifies which package categories to import via the `enabledProfilesByHost` map:

#### sithy-one (Hyprland)
```nix
"sithy-one" = [
  "base.core" "base.cliTools" "base.devTools"
  "network.base" "network.wireless" "network.bluetooth"
  "gui.base" "gui.multimedia" "gui.office" "gui.comms" "gui.design" "gui.tui"
];
```
Plus Hyprland-specific packages (waybar, mako, hyprlock, etc.)

#### sithy-top (Plasma6)
```nix
"sithy-top" = [
  "base.core" "base.cliTools" "base.devTools"
  "network.base" "network.wireless" "network.bluetooth"
  "gui.base" "gui.multimedia" "gui.office" "gui.comms" "gui.design" "gui.tui"
  "gaming.steam"
];
```

### Package Categories

**modules/packages/base/**
- [core.nix](modules/packages/base/core.nix) - Essential CLI: git, bat, zellij, fastfetch, kitty, zsh, ghostty
- [cli-tools.nix](modules/packages/base/cli-tools.nix) - Utilities: ncdu, btop, bmon, duf, isd, s-tui, vhs
- [dev-tools.nix](modules/packages/base/dev-tools.nix) - Development: direnv

**modules/packages/network/**
- [base.nix](modules/packages/network/base.nix) - Diagnostics: clinfo, dnsutils, nettools
- [wireless.nix](modules/packages/network/wireless.nix) - Wireless: networkmanagerapplet, iw
- [bluetooth.nix](modules/packages/network/bluetooth.nix) - Bluetooth: bluetui

**modules/packages/gui/**
- [base.nix](modules/packages/gui/base.nix) - Core: vscode, bitwarden-desktop, firefox, networkmanagerapplet
- [multimedia.nix](modules/packages/gui/multimedia.nix) - Media: vlc, spotify, pavucontrol
- [office.nix](modules/packages/gui/office.nix) - Productivity: libreoffice, obsidian, drawio
- [comms.nix](modules/packages/gui/comms.nix) - Communication: discord, telegram-desktop, element-desktop
- [design.nix](modules/packages/gui/design.nix) - Creative: prusa-slicer
- [tui.nix](modules/packages/gui/tui.nix) - Terminal UI: ncspot

**modules/packages/gaming/**
- [steam.nix](modules/packages/gaming/steam.nix) - Steam (sithy-top only)

## Making Changes

### System-Level Changes
```bash
# Edit system config
nano modules/systemConfig/audio.nix

# Rebuild system
sudo nixos-rebuild switch --flake .#sithy-one
```

### Home Manager Changes (Faster)
```bash
# Edit package list or user config
nano modules/packages/gui/base.nix

# Rebuild only Home Manager (no system rebuild)
home-manager switch --flake .#sithy@sithy-one
```

### Dotfile Changes
```bash
# Edit Hyprland config
nano dotfiles/hyprland/hypr/hyprland.conf

# Rebuild Home Manager to symlink changes
home-manager switch --flake .#sithy@sithy-one
```

**Important:** Files in `~/.config/` are **read-only symlinks** to the Nix store. Always edit the source files in `dotfiles/hyprland/`.

### Cleaning Up

```bash
# Delete old Home Manager generations (keep last 5 days)
home-manager expire-generations "-5 days"

# Delete old system generations (keep last 3)
sudo nix-env --delete-generations +3 --profile /nix/var/nix/profiles/system

# Clean up Nix store
nix-collect-garbage -d
sudo nix-collect-garbage -d
```

## Directory Structure

```
nix-config/
├── flake.nix                    # Entry point, mkHost function, nixosConfigurations
├── flake.lock                   # Pinned package versions
├── README.md                    # This file
│
├── configuration.nix            # Main system config, imports modules/
│
├── assets/
│   └── wlogout/                 # SVG icons for wlogout power menu
│
├── dotfiles/
│   └── hyprland/                # Hyprland config files (symlinked by HM)
│       ├── hypr/
│       │   ├── hyprland.conf
│       │   ├── hyprpaper.conf
│       │   ├── hyprlock.conf
│       │   └── hypridle.conf
│       ├── waybar/
│       │   ├── config.json
│       │   └── style.css
│       ├── wlogout/
│       │   ├── layout
│       │   └── style.css
│       ├── mako/
│       │   └── config
│       ├── kitty/
│       │   └── kitty.conf
│       └── rofi/
│           └── config.rasi
│
├── hosts/
│   ├── sithy-one/
│   │   ├── default.nix
│   │   └── hardware-configuration.nix
│   └── sithy-top/
│       ├── default.nix
│       └── hardware-configuration.nix
│
├── modules/
│   ├── default.nix              # Aggregates all system modules
│   │
│   ├── systemConfig/            # System-level configuration
│   │   ├── host-options.nix     # Defines mySystem option structure
│   │   ├── fonts.nix            # System-wide fonts
│   │   ├── audio.nix            # PipeWire setup
│   │   ├── bluetooth.nix        # Bluetooth hardware
│   │   ├── display.nix          # Display/DE/SDDM
│   │   ├── networking.nix       # NetworkManager
│   │   ├── hyprland.nix         # Hyprland system-level
│   │   ├── sysConfig.nix        # Bootloader, locale, timezone, etc.
│   │   └── zsh.nix              # Zsh system config
│   │
│   ├── hyprland/                # Hyprland-specific modules
│   │   ├── hyprland.nix         # User packages (waybar, mako, hyprlock, etc.)
│   │   ├── hyprland-config.nix  # Dotfile symlinks
│   │   └── cachix.nix           # Binary cache for faster builds
│   │
│   ├── gaming/
│   │   └── steam.nix            # System-level Steam setup
│   │
│   ├── packages/                # Home Manager package categories
│   │   ├── base/
│   │   │   ├── core.nix
│   │   │   ├── cli-tools.nix
│   │   │   └── dev-tools.nix
│   │   ├── network/
│   │   │   ├── base.nix
│   │   │   ├── wireless.nix
│   │   │   └── bluetooth.nix
│   │   ├── gui/
│   │   │   ├── base.nix
│   │   │   ├── multimedia.nix
│   │   │   ├── office.nix
│   │   │   ├── comms.nix
│   │   │   ├── design.nix
│   │   │   └── tui.nix
│   │   ├── gaming/
│   │   │   └── steam.nix
│   │   ├── sys-util-packages.nix    # OBSOLETE (see base/)
│   │   ├── gui-packages.nix         # OBSOLETE (see gui/)
│   │   └── tui-packages.nix         # OBSOLETE (see gui/tui.nix)
│   │
│   └── profiles/                # System option presets per role
│       ├── laptop.nix           # Sets mySystem.* for laptop
│       └── desktop.nix          # (placeholder for future desktop profile)
│
├── users/
│   ├── users.nix                # System user definitions
│   └── sithy/
│       └── home.nix             # Home Manager user config
│           ├── Defines enabledProfilesByHost
│           └── Imports category modules based on hostname
│
└── docs/                        # Learning examples (not used by configuration)
    ├── EXECUTION-FLOW.md
    ├── QUICK-REFERENCE.md
    ├── TROUBLESHOOTING.md
    └── examples/
        ├── 01-minimal-single-host/
        ├── 02-with-modules/
        ├── 03-with-options/
        └── 04-multi-host/
```

## What Makes This Reproducible

1. **Flake lock** pins exact nixpkgs versions
2. **Declarative only** - Everything in `.nix` files, no imperative steps
3. **Dotfiles in repo** - Hyprland configs are version-controlled
4. **No manual setup** - One command rebuilds everything
5. **Hardware detection only** - Only `hardware-configuration.nix` is machine-specific

## Configuration Options

The system uses custom NixOS options (`mySystem.*`) to control conditional behavior:

### Current Options (modules/systemConfig/host-options.nix)
- `mySystem.laptop.enable` - Enables laptop-specific features (display, touchpad, power management)
- `mySystem.laptop.environment` - `"hyprland"` or `"plasma6"`
- `mySystem.hardware.bluetooth` - Enable Bluetooth support
- `mySystem.shell.zsh` - Enable Zsh as default shell
- `mySystem.gaming.steam` - Enable Steam at system level (sithy-top)
- `mySystem.gaming.enable`, `mySystem.development.enable` - Reserved for future use

### Conditional Module Activation

Modules use `lib.mkIf` to check these options and activate accordingly:

```nix
# Example: Audio only activates for laptops
config = lib.mkIf config.mySystem.laptop.enable {
  services.pipewire.enable = true;
};
```

## Customization Examples

### Add a New Package to All Hosts
Edit the category module (e.g., [modules/packages/gui/base.nix](modules/packages/gui/base.nix)):
```nix
home.packages = with pkgs; [
  firefox
  your-new-package  # ← Add here
  ...
];
```

### Add a Package to Only One Host
Edit [users/sithy/home.nix](users/sithy/home.nix) and add a new host-specific category, or modify `enabledProfilesByHost` selectively.

### Change Hyprland Config
Edit [dotfiles/hyprland/hypr/hyprland.conf](dotfiles/hyprland/hypr/hyprland.conf), then:
```bash
home-manager switch --flake .#sithy@sithy-one
```

### Add a New Host
1. `mkdir -p hosts/your-hostname`
2. Generate hardware config: `nixos-generate-config --show-hardware-config > hosts/your-hostname/hardware-configuration.nix`
3. Create [hosts/your-hostname/default.nix](hosts/your-hostname/default.nix):
   ```nix
   { config, pkgs, ... }:
   {
     imports = [
       ./hardware-configuration.nix
       ../../modules/profiles/laptop.nix  # or desktop.nix
     ];
     networking.hostName = "your-hostname";
   }
   ```
4. Add to [flake.nix](flake.nix): `your-hostname = mkHost { hostname = "your-hostname"; };`
5. Add to [users/sithy/home.nix](users/sithy/home.nix) enabledProfilesByHost:
   ```nix
   "your-hostname" = [ "base.core" /* ... */ ];
   ```
6. Rebuild:
   ```bash
   sudo nixos-rebuild switch --flake .#your-hostname
   ```

## Learning Resources

The `docs/` directory contains standalone, progressive examples that teach NixOS flakes concepts step-by-step. These are **not imported** by the configuration but serve as learning material:

- [01-minimal-single-host](docs/examples/01-minimal-single-host/) - Simplest possible flake + single host
- [02-with-modules](docs/examples/02-with-modules/) - How modules merge and organize
- [03-with-options](docs/examples/03-with-options/) - Custom options + conditional modules (the pattern used here)
- [04-multi-host](docs/examples/04-multi-host/) - Multi-host with mkHost (as implemented here)

Work through these in order to understand the architecture before diving into the full config.

### External Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [NixOS Flakes Reference](https://nixos.wiki/wiki/Flakes)

## License

This configuration is provided as-is for educational and personal use.


