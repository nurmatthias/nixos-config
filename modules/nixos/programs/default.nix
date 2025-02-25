{pkgs, ...}: {

  imports = [
    "./corectrl"
    "./steam"
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

    # Zsh configuration
    programs.zsh.enable = true;
}
