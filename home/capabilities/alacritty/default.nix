{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  programs.alcritty = {
    enable = true;
    settings = {
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
      };
      workingDirectory = "~/";
      font = {
        normal = {
          family = "Fira code";
          style = "Regular";
        };
        bold = {
          family = "Fira code";
          style = "Bold";
        };
        italic = {
          family = "Fira code";
          style = "Italic";
        };
        boldItalic = {
          family = "Fira code";
          style = "Bold Italic";
        };
        size = 11;
      };
      window = {
        opacity = 0.9;
        position = {
          x = 100;
          y = 100;
        };
        dimensions = {
          columns = 130;
          lines = 40;
        };
        padding = {
          x = 0;
          y = 0;
        };
        startupMode = "Windowed";
        decorations = "Full";
      };
    };
    custom_cursor_colors = true;
    env = {
      TERM = "xterm-256color";
    };
    colors = {
      primary = {
        background = "#24273A";
        foreground = "#CAD3F5";
        dim_foreground = "#CAD3F5";
        bright_foreground = "#CAD3F5";
      };
      cursor = {
        text = "#24273A";
        cursor = "#F4DBD6";
      };
      vi_mode_cursor = {
        text = "#24273A";
        cursor = "#F4DBD6";
      };
      search = {
        matches = {
          foreground = "#24273A";
          background = "#A5ADCB";
        };
        focused_match = {
          foreground = "#24273A";
          background = "#A6DA95";
        };
        footer_bar = {
          foreground = "#24273A";
          background = "#A5ADCB";
        };
      };
      hints = {
        start = {
          foreground = "#24273A";
          background = "#EED49F";
        };
        end = {
          foreground = "#24273A";
          background = "#A5ADCB";
        };
      };
      selection = {
        text = "#24273A";
        background = "#F4DBD6";
      };
      normal = {
        black = "#494D64";
        red = "#ED8796";
        green = "#A6DA95";
        yellow = "#EED49F";
        blue = "#8AADF4";
        magenta = "#F5BDE6";
        cyan = "#8BD5CA";
        white = "#B8C0E0";
      };
      bright = {
        black = "#5B6078";
        red = "#ED8796";
        green = "#A6DA95";
        yellow = "#EED49F";
        blue = "#8AADF4";
        magenta = "#F5BDE6";
        cyan = "#8BD5CA";
        white = "#A5ADCB";
      };
      dim = {
        black = "#494D64";
        red = "#ED8796";
        green = "#A6DA95";
        yellow = "#EED49F";
        blue = "#8AADF4";
        magenta = "#F5BDE6";
        cyan = "#8BD5CA";
        white = "#B8C0E0";
      };
    };
    draw_bold_text_with_bright_colors = true;
    live_config_reload = true;
    scrolling = {
      history = 10000;
      multiplier = 10;
    };
    cursor = {
      style = {
        shape = "Underline";
        blinking = true;
      };
      unfocused_hollow = true;
    };
    mouse = {
      double_click.threshold = 300;
      triple_click.threshold = 300;
      hide_when_typing = true;
    };
    selection = {
      semantic_escape_chars = ",│`|:\"' ()[]{}<>";
      save_to_clipboard = true;
    };
    key_bindings = [
      {
        key = "V";
        mods = "Control|Shift";
        action = "Paste";
      }
      {
        key = "C";
        mods = "Control|Shift";
        action = "Copy";
      }
      {
        key = "Plus";
        mods = "Control";
        action = "IncreaseFontSize";
      }
      {
        key = "Minus";
        mods = "Control";
        action = "DecreaseFontSize";
      }
      {
        key = "Return";
        mods = "Alt";
        action = "ToggleFullScreen";
      }
    ];
  };
}
