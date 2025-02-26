## configuration.nix
{ config, pkgs, home, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ./modules/nixos/desktop.nix
    ./modules/nixos/hardware.nix
    ./modules/nixos/services.nix
    ./modules/nixos/system.nix
    ./modules/nixos/user_settings.nix
    
    ./modules/stylix.nix
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

