## modules/stylix.nix
{ config, pkgs, ... }:

let
  opacity = 0.95;
  fontSize = 11;
in
{
  
  stylix.enable = true;
  stylix.autoEnable = true;
  
  stylix.image = ../files/wallpaper/wallpaper.jpg;
  stylix.polarity = "dark";

  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    monospace = {
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      name = "JetBrainsMono Nerd Font Mono";
    };
    
    sizes = {
      applications = 11;
      desktop = 11;
      popups = 10;
      terminal = 11;
    };
  };
  
  #stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Breeze";
  stylix.cursor.size = 22;
      
  stylix.opacity = {
    terminal = opacity;
    popups = opacity;
  };
}
