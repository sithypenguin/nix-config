``` mermaid
flowchart TD
    A["`**nixos-rebuild --flake .#sithy-one**`"] --> B["`**flake.nix**
    Looks up nixosConfigurations.sithy-one`"]
    
    B --> C["`**configuration.nix**
    Main system config`"]
    
    B --> D["`**hosts/sithy-one/default.nix**
    Host-specific config`"]
    
    C --> E["`**system/host-options.nix**
    Defines mySystem options`"]
    
    D --> F["`**profiles/laptop.nix**
    Sets configuration values`"]
    
    F --> G["`**mySystem Values Set:**
    • laptop.enable = true
    • laptop.environment = 'plasma6'
    • gaming.steam = true
    • hardware.bluetooth = true`"]
    
    G --> H{"`**Conditional Module Evaluation**`"}
    
    H --> I["`**system/display.nix**
    IF laptop.enable || desktop.enable`"]
    
    H --> J["`**system/audio.nix**
    IF laptop.enable`"]
    
    H --> K["`**general/steam.nix**
    IF gaming.steam`"]
    
    H --> L["`**system/connectivity.nix**
    IF hardware.bluetooth`"]
    
    I --> M["`**Display Module Activates:**
    ✅ X11 server
    ✅ SDDM display manager
    ✅ Plasma6 desktop
    ✅ Touchpad support`"]
    
    J --> N["`**Audio Module Activates:**
    ✅ PipeWire
    ✅ ALSA support
    ✅ PulseAudio compatibility`"]
    
    K --> O["`**Gaming Module Activates:**
    ✅ Steam platform`"]
    
    L --> P["`**Connectivity Activates:**
    ✅ Bluetooth hardware
    ✅ Auto power-on`"]
    
    C --> Q["`**Always Active:**
    ✅ NetworkManager
    ✅ Bootloader (sysConfig.nix)
    ✅ Locale settings
    ✅ User accounts`"]
    
    M --> R["`**Final System Generation**
    All enabled modules combined`"]
    N --> R
    O --> R
    P --> R
    Q --> R
    
    R --> S["`**System Activation:**
    • Download/build packages
    • Update bootloader
    • Start/restart services
    • Apply configuration`"]
    
    style A fill:#ff9999
    style G fill:#99ccff
    style H fill:#ffcc99
    style R fill:#99ff99
    style S fill:#cc99ff
```