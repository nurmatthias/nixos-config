{...}: {
  # Zsh shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ff = "fastfetch";

      # Nix
      nupdate = "nix update flakes";
      nswitch = "sudo nixos-rebuild switch --flake ~/nixos-config/";
      hmswitch = "home-manager switch --flake ~/nixos-config/";
    };
  };
}
