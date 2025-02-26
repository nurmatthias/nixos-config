{
  description = "Workstation setup with flakes, home manager and stylix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # better management of user settings
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # System level styling for all applications and desktops
    stylix.url = "github:danth/stylix/release-24.11";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    # NixOS profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      Workstation-Matthias = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          inputs.stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.users.matthias = import ./modules/home_manager/home.nix;
          }
        ];
      };
    };

    homeConfigurations = {
      matthias = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        specialArgs = {inherit inputs;};
        modules = [
          ./modules/home.nix
          inputs.stylix.homeManagerModules.stylix
        ];
      };
    };
  };
}

