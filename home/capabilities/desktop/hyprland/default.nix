{ pkgs, inputs, ... }:

{
  imports = [
    ../wofi
  ];
  home.packages = with pkgs; [
    wl-clipboard
    arandr
    swappy
    slurp
    grim
  ];

  home.sessionVariables =
    {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

  programs.wofi.enable = true;

  home.file.".config/hypr/theme.conf" = { source = ./theme.conf; };
  home.file.".config/hypr/configs" = { source = ./configs; recursive = true; };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      ${builtins.readFile ./hyprland.conf}
    '';
  };
}
