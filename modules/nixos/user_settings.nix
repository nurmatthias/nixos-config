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
  environment.variables.NO_POINTER_VIEWPORT = 1;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  environment.shells = with pkgs; [ zsh ];

  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts
    roboto
  ];

  # System level packages/programs
  environment.systemPackages = with pkgs: [
    protonup
  ];
  
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
    
    dconf.enable = true;
  };
  
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}

