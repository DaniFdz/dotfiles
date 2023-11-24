{ config, pkgs, ... }

{
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = tru;
    xwayland.enable = true;
  };
}
