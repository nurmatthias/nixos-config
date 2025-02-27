## modules/desktop.nix
{ config, pkgs, ... }:
{
  imports = [
    ./gnome.nix
    #./kde.nix
  ];
}

