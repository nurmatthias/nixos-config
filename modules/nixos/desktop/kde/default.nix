{pkgs, ...}: 
let
  # Define the custom background package with the correct relative path
  #background-package = pkgs.stdenvNoCC.mkDerivation {
  #  name = "background-image";
  #  src = ./wallpaper.jpg;  # Place wallpaper.jpg in the same directory as this config file
  #  dontUnpack = true;
  #  installPhase = ''
  #    cp $src $out
  #  '';
  #};
  
in {
  # Enable KDE
  services.desktopManager.plasma6.enable = true;

  # activate SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    settings.General.DisplayServer = "wayland";
    theme = "breeze-dark";
  };

  # Excluding some KDE applications from the default install
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
  ];
  
  # Setting another Background for SDDM
  environment.systemPackages = [
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background=${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/MilkyWay/contents/images/5120x2880.png
      #background = "${background-package}"
    '')
  ];
}
