{ pkgs, ... }:
{
  programs.plasma = {
    enable = true;
    
    hotkeys.commands."launch-kitty" = {
      name = "Launch Konsole";
      key = "Meta+Enter";
      command = "kitty";
    };
    
    configFile.kdeglobals.General = {
      TerminalApplication = "kitty";
      TerminalService = "kitty.desktop";
    };

    kwin = {
      edgeBarrier = 0; # Disables the edge-barriers introduced in plasma 6.1
      cornerBarrier = false;

      scripts.polonium.enable = true;
    };

    configFile = {
      kwinrc.Desktops.Number = {
        value = 4;
        # Forces kde to not change this value (even through the settings app).
        immutable = true;
      };
    };
  };
}
