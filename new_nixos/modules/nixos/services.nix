## modules/services.nix
{ config, pkgs, ... }:
{

  services.libinput.enable = true;
  services.printing.enable = true;
  services.avahi.enable = true;
  services.devmon.enable = true;
  services.locate.enable = true;
  services.openssh.enable = false;
  services.blueman.enable = true;

  services.flatpak.enable = false;
  systemd.services.flatpak-repo = {
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

}
