{
    description = "Multi-Host NixOS Configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }: 
    let 
    system = "x86_64-linux";

        pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config = { allowUnfree = true; };
        };

    mkHost = { hostname, username ? "sithy", extraModules ? [] }:
        nixpkgs.lib.nixosSystem{
            inherit system;
            modules = [
                ./configuration.nix
                ./hosts/${hostname}

                home-manager.nixosModules.home-manager
                {
                    home-manager.useUserPackages = true;
                    home-manager.users.${username} = import ./users/${username}/home.nix;
                    home-manager.extraSpecialArgs = {
                        inherit pkgs-unstable;
                    };
                }
            ] ++ extraModules;
            specialArgs = {
                inherit inputs pkgs-unstable;
            };
        };
    in
    {
        nixosConfigurations = {
        sithy-one = mkHost { hostname = "sithy-one"; };
        # Add more hosts easily:
        # another-host = mkHost { hostname = "another-host"; username = "differentuser"; };
        };
    };
}