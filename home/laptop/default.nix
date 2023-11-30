{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ../capabilities/git
    ../capabilities/alacritty
    ../capabilities/kitty
    ../capabilities/terminal
    ../capabilities/nvim
    ../capabilities/tmux
    ../capabilities/desktop
		../capabilities/developing
  ];

  fonts.fontconfig.enable = true;

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  home = {
    username = "dani";
    homeDirectory = "/home/dani"; 
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    packages = with pkgs; [
      mpv
      docker-compose
			brave
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      # gtk-theme = "Catppuccin-Frappe-Standard-Blue-light";
      gtk-theme = "Catppuccin-Macchiato-Compact-Teal-Dark";
      cursor-theme = "Bibata-Modern-Ice";
      icon-theme = "Fluent-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Compact-Teal-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "teal" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "macchiato";
      };
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };

    iconTheme = {
      name = "Fluent-dark";
      package = pkgs.fluent-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-gtk";
  };

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Macchiato-Compact-Teal-Dark";
  };

  programs.home-manager.enable = true;
}