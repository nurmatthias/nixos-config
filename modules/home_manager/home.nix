## modules/packages.nix
{ config, pkgs, ... }:
{

  imports = [
    ./plasma.nix
  ];

  home = {
    username = "matthias";
    homeDirectory = "/home/matthias";
  };
  
  # Environment
  home.sessionVariables = {
    EDITOR = "nano";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
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
  
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
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

