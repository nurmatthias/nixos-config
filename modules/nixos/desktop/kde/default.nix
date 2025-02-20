{pkgs, ...}: {
  # Enable KDE
  services.desktopManager.plasma6.enable = true;

  # activate SDDM
  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
    sddm.settings.General.DisplayServer = "wayland";
  };

  # Excluding some KDE applications from the default install
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
  ];
}
