{ pkgs, inputs, ... }:

{

  imports = [
    ../waybar
    ../dunst
  ];

  home.packages = with pkgs; [ 
    wl-clipboard 
    neofetch 
    rofi
  ];

  programs.wofi.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
    extraConfig = ''
      ${builtins.readFile ./hyprland.conf}
    '';
  };
}
