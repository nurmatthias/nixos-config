{pkgs, ...}: {
  # Install alacritty via home-manager module
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        live_config_reload = true;
      };

      terminal = {
        shell.program = "zsh";
        shell.args = [
          "-l"
          "-c"
          "tmux attach || tmux "
        ];
      };

      env = {
        TERM = "xterm-256color";
      };

      window = {
        dynamic_title = true;
        dynamic_padding = true;
        dimensions = {
          columns = 170;
          lines = 45;
        };
        padding = {
          x = 5;
          y = 1;
        };
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      font = {
        size =
          if pkgs.stdenv.isDarwin
          then 15
          else 12;
        normal = {
          family = "MesloLGS Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "MesloLGS Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "MesloLGS Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "MesloLGS Nerd Font";
          style = "Italic";
        };
      };

      selection = {
        semantic_escape_chars = '',│`|:"' ()[]{}<>'';
        save_to_clipboard = true;
      };
    };
  };

}
