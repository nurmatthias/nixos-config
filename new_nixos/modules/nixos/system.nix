## modules/system.nix
{ config, pkgs, ... }:
{

  boot = {
    kernelPackages = pkgs.linuxPackages_zen; # zen Kernel

    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" #this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco" #watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" #watchdog for Intel
    ];

    # Needed For Some Steam Games
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };

    # Bootloader SystemD
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 5;

    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };


  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Keymap
  console.keyMap = "de";
  services.xserver = {
    xkb.layout = "de";
    xkb.variant = "nodeadkeys";
    excludePackages = with pkgs; [xterm];
  };

  # networking
  networking.hostName = "Workstation-Matthias";
  networking.networkmanager.enable = true;

  # zram
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };

  # Power management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };


  # essential packages
  environment.systemPackages = with pkgs; [
    git
    mesa
  ];
}
