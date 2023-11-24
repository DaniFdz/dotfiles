{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  programs.kitty = {
    enable = true;
    font = {
      name = "Fira code";
      size = 11;
    };
    keybindings = {
      "alt+left" = "neighboring_window left";
      "alt+right" = "neighboring_window right";
      "alt+up" = "neighboring_window up";
      "alt+down" = "neighboring_window down";
      "ctrl+shift+z" = "toggle_layout stack";
      "ctrl+shift+enter" = "new_window_with_cmd";
      "ctrl+shift+t" = "new_tab_with_cmd";
    };
    settings = {
      enable_audio_bell = false;
      placement_strategy = "center";
      disable_ligatures = "never";
      cursor_shape = "beam";
      cursor_beam_thickness = "1.8";
      mouse_hide_wait = "3.0";
      background_opacity = "0.96";
      detect_url = true;
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;
      inactive_tab_background = "#f7768e";
      active_tab_background = "#bb9af7";
      inactive_tab_foreground = "#000000";
      tab_bar_margin_color = "black";

      # Theme
      foreground = "#a9b1d6";
      background = "#1a1b26";
      #Black"
      color0 = "#414868";
      color8 = "#414868";
      #Red"
      color1 = "#f7768e";
      color9 = "#f7768e";
      #Green"
      color2 = "#73daca";
      color10 = "#73daca";
      #Yellow"
      color3 = "#e0af68";
      color11 = "#e0af68";
      #Blue"
      color4 = "#7aa2f7";
      color12 = "#7aa2f7";
      #Magenta"
      color5 = "#bb9af7";
      color13 = "#bb9af7";
      #Cyan"
      color6 = "#7dcfff";
      color14 = "#7dcfff";
      #White"
      color7 = "#c0caf5";
      color15 = "#c0caf5";
      cursor = "#c0caf5";
      cursor_text_color = "#1a1b26";
      #Selection = highlight"
      selection_foreground = "none";
      selection_background = "#28344a";
      url_color = "#9ece6a";
      #Window = borders"
      active_border_color = "#3d59a1";
      inactive_border_color = "#101014";
      bell_border_color = "#e0af68";
    };
  };
}
