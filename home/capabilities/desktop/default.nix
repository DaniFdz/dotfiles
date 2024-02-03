{ pkgs, ... }:

{
  imports = [
		./hyprland
    ./dunst
    ./webcord
  ];

  home.file.".wallpapers" = { source = ./wallpapers; recursive = true; };
  home.file.".config/waybar" = { source = ./waybar; recursive = true; };

  home.packages = with pkgs; [
    neofetch
    gnome.nautilus
    playerctl
    swww
    waybar
    discord
    globalprotect-openconnect

    imagemagick
    brightnessctl

    obsidian
  ];

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Macchiato-Compact-Teal-Dark";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
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

}
