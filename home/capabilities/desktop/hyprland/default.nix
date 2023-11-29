{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [ 
    wl-clipboard 
    neofetch 
    rofi
  ];

  programs.wofi.enable = true;

	home.file."${config.home.homeDirectory}/hypr/macchiato.conf" = { source = macchiato.conf; };
	home.file."${config.home.homeDirectory}/hypr/configs" = { source = ./configs; recursive = true; };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      ${builtins.readFile ./hyprland.conf}
    '';
  };
}
