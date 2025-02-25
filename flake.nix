{
  description = "NixOS config for my machine";
  
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Plasma Manager - Settings for KDE
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # NixOS profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Define user configurations
    users = {
      matthias = {
        email = "matthias@engelien.info";
        fullName = "Matthias Engelien";
        name = "matthias";
      };
    };

    # Function for NixOS system configuration
    mkNixosConfiguration = hostname: username:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
          nixosModules = "${self}/modules/nixos";
        };
        modules = [./hosts/${hostname}];
      };

    # Function for Home Manager configuration
    mkHomeConfiguration = system: username:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {inherit system;};
        extraSpecialArgs = {
          inherit inputs outputs;
          userConfig = users.${username};
          nhModules = "${self}/modules/home-manager";
        };
        modules = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
          ./home/${username}
        ];
      };
  in {
    nixosConfigurations = {
      Workstation-Matthias = mkNixosConfiguration "Workstation-Matthias" "matthias";
    };

    homeConfigurations = {
      "matthias" = mkHomeConfiguration "x86_64-linux" "matthias";
    };

    overlays = import ./overlays {inherit inputs;};
  };
}
