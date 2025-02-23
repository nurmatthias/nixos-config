{
  inputs,
  hostname,
  nixosModules,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-amd

    ./hardware-configuration.nix
    "${nixosModules}/common"
    "${nixosModules}/hardware"
    "${nixosModules}/desktop/hyprland"
    #"${nixosModules}/desktop/gnome"
    #"${nixosModules}/desktop/kde"
    "${nixosModules}/programs/steam"
  ];

  # Set hostname
  networking.hostName = hostname;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.11";
}
