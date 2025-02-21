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
    extraPackages = with pkgs; [rocmPackages.clr.icd];
  };

  hardware.amdgpu = {
    amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };

      opencl.enable = true;

      initrd.enable = true;
  };

  # enable xbox one dongle
  hardware.xone.enable = true;

}
