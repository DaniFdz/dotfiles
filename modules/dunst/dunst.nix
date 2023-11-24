{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    libnotify
  ];

  servicies.dunst = {
    enable = true;
    configFile = ./dunstrc;
  };
}
