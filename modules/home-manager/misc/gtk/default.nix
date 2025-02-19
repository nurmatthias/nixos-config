{
  userConfig,
  pkgs,
  ...
}: {
  # GTK theme configuration
  gtk = {
    enable = true;
    iconTheme = {
      name = "Tela-circle-dark";
      package = pkgs.tela-circle-icon-theme;
    };
    cursorTheme = {
      name = "Yaru";
      package = pkgs.yaru-theme;
      size = 24;
    };
    font = {
      name = "Roboto";
      size = 11;
    };
    gtk3 = {
      bookmarks = [
        "file:///home/${userConfig.name}/Dokumente"
        "file:///home/${userConfig.name}/Downloads"
        "file:///home/${userConfig.name}/Bilder"
        "file:///home/${userConfig.name}/Videos"
      ];
    };
  };

  # Enable catppuccin theming for GTK apps.
  catppuccin = {
    gtk = {
      enable = true;
      gnomeShellTheme = true;
    };
  };
}
