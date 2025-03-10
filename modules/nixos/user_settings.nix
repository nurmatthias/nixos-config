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
  environment.systemPackages = with pkgs; [
    protonup
    git
    mesa
    xsettingsd
    xorg.xrdb
    nvtop
  ];
  
  programs = {
    corectrl = {
      enable = true;
      gpuOverclock = {
        enable = true;
        ppfeaturemask = "0xffffffff";
      };
    };

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
    
    kdeconnect.enable = true;
  };

  programs.firefox = {
    enable = true;

    languagePacks = ["de"];

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      DisablePocket = false;
      SearchBar = "unified";

      Preferences = {
        # Privacy settings
        "extensions.pocket.enabled" = false;
        "browser.newtabpage.pinned" = "";
        "browser.topsites.contile.enabled" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      };

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
  
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      xdg-desktop-portal-kde
      xdg-desktop-portal-gnome
    ];
  };

}

