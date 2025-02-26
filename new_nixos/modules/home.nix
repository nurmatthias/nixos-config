## modules/packages.nix
{ config, pkgs, ... }:
{
  # PATH configuration
#  environment.localBinInPath = true;

  # Environment variables
#  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Fonts
#  fonts.packages = with pkgs; [
#    nerdfonts
#    roboto
#  ];

  home = {
    username = "matthias";
    homeDirectory = "/home/matthias";
  };

  home.packages = with pkgs; [
    discord
    bambu-studio
    orca-slicer
    lutris
    heroic
    jetbrains.idea-community
    mangohud
  ];


  # System level packages/programs
# programs.steam = {
#    enable = true;
#    gamescopeSession.enable = true;
#  };
#  programs.gamescope.enable = true;
#  programs.gamemode.enable = true;

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "nurMatthias";
    userEmail = "git@engelien.info";
    extraConfig = {
      pull.rebase = "true";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      directory = {
        style = "bold lavender";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = { };
  };


  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

}

