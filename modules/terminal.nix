{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    zsh
    bat
    lsd
    xclip
    neovim
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      ll = "lsd -lh --group-dirs=first";
      la = "lsd -a --group-dirs=first";
      l = "lsd --group-dirs=first";
      lla = "lsd -lha --group-dirs=first";
      ls = "lsd --group-dirs=first";
      cat = "bat -P";
      catl = "bat";
      catn = "/bin/cat";
      get-my-ip = "echo (ifconfig | grep 'inet ' | awk '{print 2}' | grep -v '127.0.0.1')";
      cc = "xclip -sel clip";
      my-ip = "get-my-ip && get-my-ip | cc";
      pwd = "pwd && pwd | cc";
      python = "python3";
      py = "python3";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      pdw = "pwd";
      naut = "nautilus";
      tb = "nc termbin.com 9999";
    };
    envExtra = ''
      [[ ! -f /home/dani/.p10k.zsh ]] || source ~/.p10k.zsh
      [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

      # configure key keybindings
      bindkey -e                                        # emacs key bindings
      bindkey ' ' magic-space                           # do history expansion on space
      bindkey '^[[3;5~' kill-word                       # ctrl + Supr
      bindkey '^[[3~' delete-char                       # delete
      bindkey '^[[1;5C' forward-word                    # ctrl + ->
      bindkey '^[[1;5D' backward-word                   # ctrl + <-
      bindkey '^[[5~' beginning-of-buffer-or-history    # page up
      bindkey '^[[6~' end-of-buffer-or-history          # page down
      bindkey '^[[H' beginning-of-line                  # home
      bindkey '^[[F' end-of-line                        # end
      bindkey '^[[Z' undo
      bindkey '[C' forward-word
      bindkey '[D' backward-word
      bindkey '^H' backward-kill-word
      bindkey "\e[3;5~" kill-word
      bindkey "\e[3~" delete-char
      bindkey "\e[H"  beginning-of-line
      bindkey "\e[F"  end-of-line
    '';

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "none9632/zsh-sudo"; }
        { name = "zdharma-continuum/fast-syntax-highlighting"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
  };

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
