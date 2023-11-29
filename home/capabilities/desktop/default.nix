{ pkgs, ... }:

{
  imports = [
    ./hyprland
		./waybar
		./dunst
		./rofi
  ];

	home.file.".wallpapers" = { source = ./wallpapers; recursive = true; };

  home.packages = with pkgs; [ 
    webcord
    gnome.nautilus
    arandr
		swww
  ];

  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
