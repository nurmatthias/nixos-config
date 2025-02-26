## modules/users.nix
{ config, pkgs, ... }:
{
  users.users.matthias = {
    description = "Matthias";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  
  # PATH configuration
  environment.localBinInPath = true;

  # Environment variables
  # temporary fix for https://github.com/NixOS/nixpkgs/issues/353588
  environment.variables.GSK_RENDERER = "gl";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  environment.shells = with pkgs; [ zsh ];

  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts
    roboto
  ];

  # System level packages/programs
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamescope.enable = true;
    gamemode.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}

