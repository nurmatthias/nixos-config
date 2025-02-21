{...}: {
  # Steam gaming platform configuration
  programs.steam = {
    enable = true;
    #remotePlay.openFirewall = true;

    gamescopeSession.enable = true;
  };

  programs.gamescope.enable = true;
}
