{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [ 
    wl-clipboard 
    neofetch 
  ];

  programs.wofi.enable = true;

	home.file.".config/hypr/macchiato.conf" = { source = ./macchiato.conf; };
	home.file.".config/hypr/configs" = { source = ./configs; recursive = true; };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      ${builtins.readFile ./hyprland.conf}
    '';
  };
}
