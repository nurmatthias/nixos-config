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
    ../programs/git
    ../programs/gpg
    ../programs/starship
    ../programs/zsh
    ../scripts
    ../services
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
    homeDirectory = "/home/${userConfig.name}";
  };

  # Ensure common packages are installed
  home.packages = with pkgs;
    [
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
