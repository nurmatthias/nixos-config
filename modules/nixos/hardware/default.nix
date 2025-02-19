{pkgs, ...}: {

  # Enables support for Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Enable Bluetooth support
  services.blueman.enable = true;

  # Enables OpenGL support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # enable xbox one dongle
  hardware.xone.enable = true;

}
