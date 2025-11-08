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