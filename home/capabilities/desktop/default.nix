{ pkgs, ... }:

{
  imports = [
    ./hyprland
  ];

  home.packages = with pkgs; [ 
    webcord
    gnome.nautilus
    arandr
  ];

  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
