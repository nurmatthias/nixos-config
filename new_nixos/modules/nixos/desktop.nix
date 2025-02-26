## modules/desktop.nix
{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = "matthias";
  };
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.systemPackages = with pkgs; [
    adwaita-qt
    adwaita-qt6
    adwaita-icon-theme
    gnome-settings-daemon

    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.pop-shell
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-software
  ];
}

