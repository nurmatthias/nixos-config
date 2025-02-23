{
  outputs,
  userConfig,
  pkgs,
  ...
}: {
  imports = [
    ../programs/alacritty
    ../programs/brave
    ../programs/fastfetch
    ../programs/fzf
    ../programs/git
    ../programs/gpg
    ../programs/starship
    ../programs/tmux
    ../programs/zsh
    ../scripts
  ];

  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      #outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };

  # Home-Manager configuration for the user's home environment
  home = {
    username = "${userConfig.name}";
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/${userConfig.name}"
      else "/home/${userConfig.name}";
  };

  # Ensure common packages are installed
  home.packages = with pkgs;
    [
      dig
      du-dust
      eza
      fd
      jq
      nh
      ripgrep
      pavucontrol
      pulseaudio
      tesseract
      unzip
      wl-clipboard
      
      # GUI Apps
      discord
      bambu-studio
      orca-slicer
      lutris
      heroic
      jetbrains.idea-community
      mangohud
    ];

}
