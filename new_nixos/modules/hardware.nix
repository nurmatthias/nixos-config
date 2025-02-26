## modules/services.nix
{ config, pkgs, ... }:
{

  # Enable PipeWire for sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

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
