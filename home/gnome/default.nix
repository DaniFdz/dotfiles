{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ../capabilities/git
    ../capabilities/kitty
    ../capabilities/firefox
    ../capabilities/terminal
    ../capabilities/nvim
    ../capabilities/tmux
  ];

  fonts.fontconfig.enable = true;

  home = {
    username = "dani";
    homeDirectory = "/home/dani"; 
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    packages = with pkgs; [
      mpv
      docker-compose
    ];
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      # gtk-theme = "Catppuccin-Frappe-Standard-Blue-light";
      gtk-theme = "Catppuccin-Mocha-Standard-Blue-Dark";
      cursor-theme = "Bibata-Modern-Ice";
      icon-theme = "Fluent-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      # name = "Catppuccin-Frappe-Standard-Blue-light";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard"; # compact
        tweaks = [];
        variant = "mocha";
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
    GTK_THEME = "Catppuccin-Mocha-Standard-Blue-Dark";
    # If cursor becomes invisible
    # WLR_NO_HARDWARE_CURSORS = "1";
  };

  programs.home-manager.enable = true;
}
