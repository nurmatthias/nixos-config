{
  inputs,
  outputs,
  lib,
  config,
  userConfig,
  pkgs,
  ...
}: {
  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      #outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };

  # Register flake inputs for nix commands
  nix.registry = lib.mapAttrs (_: flake: {inherit flake;}) (lib.filterAttrs (_: lib.isType "flake") inputs);

  # Nix settings
  nix = {
      settings = {
        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };

  boot = {
      kernelPackages = pkgs.linuxPackages_zen; # zen Kernel

      kernelParams = [
        "systemd.mask=systemd-vconsole-setup.service"
        "systemd.mask=dev-tpmrm0.device" #this is to mask that stupid 1.5 mins systemd bug
        "nowatchdog"
        "modprobe.blacklist=sp5100_tco" #watchdog for AMD
        "modprobe.blacklist=iTCO_wdt" #watchdog for Intel
   	  ];

      initrd = {
        availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
        kernelModules = [ ];
      };

      # Needed For Some Steam Games
      kernel.sysctl = {
        "vm.max_map_count" = 2147483642;
      };

      # Bootloader SystemD
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      loader.timeout = 5;

      # Make /tmp a tmpfs
      tmp = {
        useTmpfs = false;
        tmpfsSize = "30%";
      };

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

  # Networking
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "Europe/Berlin";

  # Internationalization
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
  console.keyMap = "de-latin1-nodeadkeys";

  # Input settings
  services.libinput.enable = true;

  # X11 settings
  services.xserver = {
    enable = true;
    xkb.layout = "de";
    xkb.variant = "nodeadkeys";
    excludePackages = with pkgs; [xterm];
  };

  # PATH configuration
  environment.localBinInPath = true;

  # Disable CUPS printing
  services.printing.enable = false;

  # Enable devmon for device management
  services.devmon.enable = true;

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

  # User configuration
  users.users.${userConfig.name} = {
    description = userConfig.fullName;
    extraGroups = ["networkmanager" "wheel"];
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  # Passwordless sudo
  #security.sudo.wheelNeedsPassword = false;

  # System packages
  environment.systemPackages = with pkgs; [
    git
    mesa
    xsettingsd
  ];

  # Docker configuration
  #virtualisation.docker.enable = true;
  #virtualisation.docker.rootless.enable = true;
  #virtualisation.docker.rootless.setSocketVariable = true;

  flatpak.enable = false;
  systemd.services.flatpak-repo = {
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };

    # zram
    zramSwap = {
  	  enable = true;
  	  priority = 100;
  	  memoryPercent = 30;
  	  swapDevices = 1;
      algorithm = "zstd";
      };

    powerManagement = {
        enable = true;
  	    cpuFreqGovernor = "schedutil";
    };

  # Fonts configuration
  fonts.packages = with pkgs; [
    nerdfonts
    roboto
  ];

  # Additional services
  services.locate.enable = true;

  # OpenSSH daemon
  services.openssh.enable = true;

  # environment variables
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
