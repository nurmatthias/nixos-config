{
  config,
  lib,
  nhModules,
  pkgs,
  ...
}: {
  programs.plasma = {
    enable = true;

  };

  home.packages = with pkgs; [
    nordic
    breath-theme
    layan-kde
    arc-kde-theme
  ];
}
