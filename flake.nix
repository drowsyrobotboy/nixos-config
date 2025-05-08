# This file defines the NixOS configuration using flakes.

{
  description = "Nixos configuration for robotboy-code";

  inputs = {
    # Nixpkgs - the primary source for packages and modules
    # Using the 24.11 release branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    # Home Manager - remove this from configuration.nix
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11"; # Use the 24.11 release branch
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    # Define the system architecture. One needs to be commented
    # system = "x86_64-linux";
    system = "aarch64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    # Define the configuration for your host, matching networking.hostName
    nixosConfigurations."robotboy-code" = nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = { inherit inputs pkgs; };

      modules = [
        # Import your hardware configuration file
        ./hardware-configuration.nix

        # Import the Home Manager module for NixOS.
        # This replaces the '<home-manager/nixos>' import from configuration.nix.
        home-manager.nixosModules.home-manager

        # Import your main configuration.nix file.
        ./configuration.nix

        # Configure Home Manager for your user(s) here instead of configuration.nix.
        {
          home-manager = {
             useGlobalPkgs = true;
             useUserPackages = true;
             users.maruthi = import ./home.nix;
          };
        }
      ];
    };
  };
}
