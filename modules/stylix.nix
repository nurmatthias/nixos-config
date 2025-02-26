## modules/stylix.nix
{ config, pkgs, ... }:

let
  opacity = 0.95;
  fontSize = 11;
in
{
  
  stylix.enable = true;
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
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
    
    sizes = {
      applications = fontSize;
      desktop = fontSize;
      popups = fontSize;
      terminal = fontSize;
    };
  };
  
  cursor = {
    package = pkgs.apple-cursor;
    name = "apple_cursor";
    size = 22;
  };
  
  stylix.opacity = {
    terminal = opacity;
    popups = opacity;
  };
}
