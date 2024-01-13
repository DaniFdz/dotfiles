{ pkgs, ... }:

{
  imports = [
    ./hyprland
		./dunst
		./wofi
		./webcord
  ];

	home.file.".wallpapers" = { source = ./wallpapers; recursive = true; };
	home.file.".config/waybar" = { source = ./waybar; recursive = true; };

  home.packages = with pkgs; [ 
    gnome.nautilus
    arandr
		playerctl
		swww
		waybar
		discord
		globalprotect-openconnect

		grim
		slurp
		imagemagick
		swappy
		brightnessctl

		obsidian
  ];

  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Macchiato-Compact-Teal-Dark";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
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
