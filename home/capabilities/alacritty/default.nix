{ config, pkgs, ... }:

{
  home.file.".config/alacritty/alacritty.yml".source = ./alacritty.yml;

  programs.alacritty = {
    enable = true;
  };
}
