{
    # Required: Description of the flake
    description = "Multi-Host NixOS Configuration";

    # Required: Inputs structure for the flake
    # nixpkgs.url specifies the Nixpkgs version and dependencies to use
    # nixpkgs-unstable.url specifies the unstable branch of Nixpkgs for newer packages
    # home-manager.url specifies the Home Manager flake
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        # Pinned to the nixpkgs revision in hermes-agent's own flake.lock.
        # Do NOT add `inputs.nixpkgs.follows = "nixpkgs"`: the upstream package
        # needs pnpm >= 11 and a patchelf whose patch set still applies, and
        # nixos-26.05 provides neither (pnpm.override missing; patchelf 0.15.2
        # patch hunks fail). Following this repo's nixpkgs breaks the build.
        hermes-agent = {
            url = "github:NousResearch/hermes-agent";
            inputs.nixpkgs.url = "github:NixOS/nixpkgs/02c087f3fe673c9e317f206a627cb6b910336dbe";
            # Share this repo's Home Manager rather than pulling a second
            # revision: two HM versions in one evaluation is a latent
            # inconsistency, and nothing here uses hermes-agent's HM module.
            inputs.home-manager.follows = "home-manager";
        };
    };

    # Required: Outputs structure for the flake
    outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, hermes-agent, ... }: 

    # let...in block for local variables
    let 
    
    # System architecture - could be aarch64-linux for ARM
    system = "x86_64-linux";

    # Creates a package set from unstable nixpkgs with unfree packages allowed
    pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = { allowUnfree = true; };
    };

    # Helper function to create NixOS systems for different hosts.
    #
    # `profile` selects the role policy from modules/profiles/ — one of base,
    # graphical, desktop, laptop, server. It is a required argument so the
    # topology of the fleet is readable from this file alone.
    mkHost = { hostname, profile, username ? "sithy", extraModules ? []}:

        # nixpkgs.lib.nixosSystem is provided by NixOS
        nixpkgs.lib.nixosSystem{
            inherit system;

            # List of NixOS Modules that make up the system configuration
            modules = [
                ./configuration.nix     # Main system configuration. Applied to all systems that are made this way
                ./modules/profiles/${profile}.nix  # Role policy, selected here
                ./hosts/${hostname}     # Host-specific configuration found in ./hosts/${hostname}


                # Home Manager integration for user-specific configuration
                home-manager.nixosModules.home-manager
                ({ config, ... }: {
                  home-manager.useUserPackages = true;
                  # Share the system package set instead of building a second
                  # instance: HM then inherits nixpkgs.config from sysConfig.nix,
                  # so home.nix no longer needs its own allowUnfree.
                  home-manager.useGlobalPkgs = true;
                  home-manager.backupFileExtension = "backup";
                  home-manager.users.${username} = import ./users/${username}/home.nix;
                  home-manager.extraSpecialArgs = {
                    inherit pkgs-unstable hostname;
                    mySystem = config.mySystem;  # now in scope
                    # Hermes desktop package, so modules/packages/gui/hermes-desktop.nix
                    # does not need to know the flake input's attribute path.
                    hermesDesktop = hermes-agent.packages.${system}.desktop;
                  };
                })

                # Tie the account name to the same `username` argument, so
                # mkHost { username = "alice"; } creates `alice` rather than
                # leaving users/users.nix pointing at a different account.
                { mySystem.primaryUser = username; }
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
        sithy-one = mkHost { hostname = "sithy-one"; profile = "laptop"; };
        sithy-top = mkHost { hostname = "sithy-top"; profile = "desktop"; };
        # Add more hosts easily — one line per machine:
        # sithy-two = mkHost { hostname = "sithy-two"; profile = "desktop"; };
        # srv-a     = mkHost { hostname = "srv-a";     profile = "server"; };
        # other     = mkHost { hostname = "other";     profile = "desktop"; username = "differentuser"; };
        };

        # `nix fmt` — one formatter for every .nix file in the tree.
        formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;

        # `nix develop` — a shell with the tools needed to edit this repo.
        devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
            packages = with nixpkgs.legacyPackages.${system}; [
                nixfmt
                nil
                nixd
            ];
        };

        # `nix flake check` runs these. They encode the properties the profile
        # layering is supposed to guarantee, so a future edit that breaks one
        # fails the check instead of being noticed later.
        checks.${system} = let
            inherit (nixpkgs) lib;
            pkgs' = nixpkgs.legacyPackages.${system};
            # Read the user from the host's own evaluated config rather than
            # hardcoding a name: hosts may run different accounts (a server per
            # role), and a hardcoded name fails with "attribute 'sithy' missing"
            # the moment one does.
            hostPackages = host:
                let cfg = self.nixosConfigurations.${host}.config;
                    users = builtins.attrNames cfg.home-manager.users;
                in if users == [] then []
                   else cfg.home-manager.users.${builtins.head users}.home.packages;
            guiPrefixes = [ "firefox" "chromium" "vscode" "discord" "steam" "spotify" "libreoffice" ];
            guiOn = host: builtins.filter
                (p: lib.any (g: lib.hasPrefix g p.name) guiPrefixes)
                (hostPackages host);

            # Every host whose profile is server.nix must carry zero GUI packages.
            serverHosts = builtins.filter
                (h: (self.nixosConfigurations.${h}.config.mySystem.environment or null) == null)
                (builtins.attrNames self.nixosConfigurations);
            offenders = builtins.concatMap
                (h: map (p: "${h}: ${p.name}") (guiOn h))
                serverHosts;
        in {
            server-profile-is-headless = pkgs'.runCommand "check-server-headless" {} (
                if offenders == []
                then ''echo "ok: ${toString (builtins.length serverHosts)} headless host(s), no GUI packages" > $out''
                else ''echo "GUI packages on headless hosts: ${lib.concatStringsSep ", " offenders}" >&2; exit 1''
            );
        };

    };
}