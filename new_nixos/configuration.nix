## configuration.nix
{ config, pkgs, home, ... }:
{
  imports = [
    ./hardware-configuration.nix
#    hardware.nixosModules.common-cpu-intel
#    hardware.nixosModules.common-gpu-amd

    ./modules/desktop.nix
    ./modules/hardware.nix
#    ./modules/home.nix
    ./modules/users.nix
    ./modules/services.nix
    ./modules/stylix.nix
    ./modules/system.nix
  ];


  # Nix settings
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Nixpkgs configuration
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}

