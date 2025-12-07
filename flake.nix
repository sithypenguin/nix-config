{
    # Required: Description of the flake
    description = "Multi-Host NixOS Configuration";

    # Required: Inputs structure for the flake
    # nixpkgs.url specifies the Nixpkgs version and dependencies to use
    # nixpkgs-unstable.url specifies the unstable branch of Nixpkgs for newer packages
    # home-manager.url specifies the Home Manager flake
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.11";
            # This ensures that home-manager uses the same nixpkgs as the flake.
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    # Required: Outputs structure for the flake
    outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }: 

    # let...in block for local variables
    let 
    
    # System architecture - could be aarch64-linux for ARM
    system = "x86_64-linux";

    # Creates a packaage set from unstable nixpkgs with unfree packages allowed
    pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = { allowUnfree = true; };
    };

    # Helper function to create NixOS systems for different hosts
    # When called, it takes in hostname, username (but will default to "sithy") and optional extra modules
    mkHost = { hostname, username ? "sithy", extraModules ? [] }:

        # nixpkgs.lib.nixosSystem is provided by NixOS
        nixpkgs.lib.nixosSystem{
            inherit system;

            # List of NixOS Modules that make up the system configuration
            modules = [
                ./configuration.nix     # Main system configuration. Applied to all systems that are made this way
                ./hosts/${hostname}     # Host-specific configuration found in ./hosts/${hostname}


                # Home Manager integration for user-specific configuration
                home-manager.nixosModules.home-manager
                {
                    home-manager.useUserPackages = true;

                    # Import user's home.nix configuration.
                    home-manager.users.${username} = import ./users/${username}/home.nix;

                    # Pass extra arguments to home-manager modules
                    home-manager.extraSpecialArgs = {
                        inherit pkgs-unstable;
                    };
                }
            ] ++ extraModules; # Appends any additional modules passed to mkHost

            # Pass extra arguments to all NixOS modules
            specialArgs = {
                inherit inputs pkgs-unstable;
            };
        };
    in
    # Return the flake outputs
    {
        # Define available NixOS system configurations
        nixosConfigurations = {
        sithy-one = mkHost { hostname = "sithy-one"; };
        # Add more hosts easily:
        # another-host = mkHost { hostname = "another-host"; username = "differentuser"; };
        };
    };
}