{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
    extraConfig = ''
      ${builtins.readFile ./hyprland.conf}
    '';
  };

  home.sessionVariables = {
    # If cursor becomes invisible
    # WLR_NO_HARWARE_CURSORS = "1";
    # Allow electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };
}
