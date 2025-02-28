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
    
    # Plasma Manager to configer KDE
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, ... }@inputs: 
  let
    username = "matthias";
    hostname = "Workstation-Matthias";
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      ${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          inputs.stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
            
            home-manager.users."${username}" = import ./modules/home_manager/home.nix;
          }
        ];
      };
    };

    homeConfigurations = {
      matthias = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        
        specialArgs = {inherit inputs;};
        modules = [
          ./modules/home.nix
          inputs.plasma-manager.homeManagerModules.plasma-manager
          inputs.stylix.homeManagerModules.stylix
        ];
      };
    };
  };
}

