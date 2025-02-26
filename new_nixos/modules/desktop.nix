## modules/desktop.nix
{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "matthias";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.systemPackages.pkgs = [
    adwaita-qt
    adwaita-qt6
    adwaita-icon-theme
    gnome-settings-daemon
  ];

  environment.systemPackages = with pkgs.gnomeExtensions; [
    appindicator
    blur-my-shell
    pop-shell
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-software
  ];

  # Patch triple buffering
  nixpkgs.overlays = [
    # GNOME 46: triple-buffering-v4-46
    (final: prev: {
      mutter = prev.mutter.overrideAttrs (old: {
        src = pkgs.fetchFromGitLab  {
          domain = "gitlab.gnome.org";
          owner = "vanvugt";
          repo = "mutter";
          rev = "triple-buffering-v4-46";
          hash = "sha256-C2VfW3ThPEZ37YkX7ejlyumLnWa9oij333d5c4yfZxc=";
        };
      });
    })
  ];
}

