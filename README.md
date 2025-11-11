# NixOS Configuration

Multi-host NixOS configuration using flakes

## Usage

## Initial Installation
```bash
sudo nixos-rebuild switch --flake github:sithypenguin/nix-config#sithy-one
```

### Available Hosts
- 'sithy-one' - Main desktop configuration

### Adding a New Host
1. Create 'hosts/new-hostname/default.nix'
2. Add hardware configuration to 'hosts/new-hostname/hardware-configuration.nix'
3. Add the host to 'flake.nix' nixosConfigurations


# Execution Path
## 1. Flake Discovery & Parsing
> sudo nixos-rebuild --flake .#sithy-one

- NixOS looks for flake.nix in the current directory
- Parses the flake and looks for nixosConfiguration.sithy-one
- Calls the mkHost function with { hostname = sithy-one }

## 2. System Config Assembly
- The mkHost function builds the module list in this order
```
modules = [
    ./configuration.nix     # ← First
    ./hosts/sithy-one      # ← Second  
    home-manager.nixosModules.home-manager  # ← Third
    { home-manager config }  # ← Fourth
]
```

## 3. Module Import Chain
The exact evaluation order:
### 3a. configuration.nix
``` 
imports = [ ./modules ];
```

### 3b. default.nix
```
imports = [
    ./systemConfig/fonts.nix          # ← Fonts loaded
    ./systemConfig/audio.nix          # ← Audio config loaded
    ./systemConfig/bluetooth.nix      # ← Bluetooth config loaded  
    ./systemConfig/display.nix        # ← Display config loaded
    ./systemConfig/host-options.nix   # ← OPTIONS DEFINED HERE
    ./systemConfig/networking.nix     # ← Networking config loaded
    ./systemConfig/sysConfig.nix      # ← Basic system config loaded
    ./gaming/steam.nix                # ← Gaming config loaded
    ../users/users.nix                # ← User accounts loaded
];
```

### 3c. default.nix
```
imports = [
    ./hardware-configuration.nix        # ← Hardware detection
    ../../modules/profiles/laptop.nix   # ← Profile configuration
];
networking.hostName = "sithy-one"       # ← Hostname set
 ```

 ### 3d. laptop.nix
 ```
 myStstem = {
    laptop.enable = true;
    laptop.environment = "plasma6";
    gaming.enable = true;
    gaming.steam = true;
    development.enable = true;
    hardware.bluetooth = true;
 };
 ```

 ### 4. Conditional Module Evaluation
 Now NixOS evaluates all the conditional logic:

 Audio Module (audio.nix)
 ```
config = lib.mkIf (config.mySystem.laptop.enable) {  # ← TRUE, so activates
    security.rtkit.enable = true;
    services.pipewire = { ... };
};
 ```

Display Module (display.nix)
```
config = lib.mkIf (config.mySystem.laptop.enable || config.mySystem.desktop.enable) {  # ← TRUE
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;      # ← Plasma6 condition met
    services.desktopManager.plasma6.enable = true;   # ← Plasma6 enabled
    services.libinput.enable = true;                 # ← Touchpad for laptop
};
```

Bluetooth Module (bluetooth.nix)
```
config = lib.mkIf config.mySystem.hardware.bluetooth {  # ← TRUE, so activates
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
};
```

Steam Module (steam.nix)
```
config = lib.mkIf config.mySystem.gaming.steam {  # ← TRUE, so activates
    programs.steam.enable = true;
};
```

### 5. Home Manager Integration
```
home-manager.users.sithy = import ./users/sithy/home.nix;
```
Home Manager Module Chain (home.nix)
```
imports = [
    ../modules/packages/sys-util-packages.nix  # ← User packages loaded
    ../modules/packages/gui-packages.nix       # ← GUI packages loaded  
    ../modules/packages/tui-packages.nix       # ← TUI packages loaded
];
```

### 6. Final System Generation

NixOS combines all active configurations:

- Always Active: Fonts, basic system config, users, networking
- Conditionally Active: audio (laptop), Display (Plasma6), Bluetooth, Steam
- User Packages: All packages from Home Manager modules

### 7.Build & Activation
1. Evaluation: All Nix expressions evaluated to determine what needs to be built
2. Building: Missing packages downloaded/compiled
3. Generation: New system generation created in store
4. Switching:

    - Bootloader updated
    - Services stopped/started as needed
    - New configuration activated


