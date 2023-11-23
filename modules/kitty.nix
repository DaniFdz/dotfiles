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
    theme = "Dracula";
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
    };
  };
}
