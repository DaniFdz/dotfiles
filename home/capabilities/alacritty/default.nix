{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  home.file.".config/alacritty/alacritty.yml".source = ./alacritty.yml;

  programs.alacritty = {
    enable = true;
  };
}
