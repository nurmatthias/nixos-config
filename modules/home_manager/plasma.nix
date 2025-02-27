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
  };
}