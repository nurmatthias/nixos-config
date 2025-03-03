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

    configFile = {
      kwinrc.Desktops.Number = {
        value = 4;
        # Forces kde to not change this value (even through the settings app).
        immutable = true;
      };
    };
  };
}
