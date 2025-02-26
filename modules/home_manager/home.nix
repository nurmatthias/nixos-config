## modules/packages.nix
{ config, pkgs, ... }:
{

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
    firefox
  ];

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

