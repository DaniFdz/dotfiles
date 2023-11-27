{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  home.file."alacritty".source = ./alacritty.yml;

  programs.alacritty = {
    enable = true;
  };
}
