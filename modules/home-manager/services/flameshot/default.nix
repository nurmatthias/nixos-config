{userConfig, ...}: {
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
	
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        contrastOpacity = 96;
        drawColor = "#ff2800";
        drawFontSize = "4";
        saveAsFileExtension = ".png";
        savePath = "/home/${userConfig.name}/Bilder";
        savePathFixed = "true";
        showDesktopNotification = "true";
        showHelp = "false";
        showMagnifier = "true";
        showStartupLaunchMessage = "false";
        squareMagnifier = "true";
        startupLaunch = "true";
        uiColor = "#8aadf4";
      };
    };
  };

  # Set env vars so flameshot works under wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
  };
}
