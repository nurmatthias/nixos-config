## modules/users.nix
{ config, pkgs, ... }:
{
  users.users.matthias = {
    description = "Matthias";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
#    shell = pkgs.zsh;
  };
}

