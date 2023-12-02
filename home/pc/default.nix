{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ../capabilities/git
    ../capabilities/alacritty
    ../capabilities/kitty
    ../capabilities/terminal
    ../capabilities/nvim
    ../capabilities/tmux
    ../capabilities/desktop
		../capabilities/developing
  ];

  fonts.fontconfig.enable = true;

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

	home.file.".config/hypr/configs/monitor.conf" = { source = ./monitor.conf; recursive = true; };

  home = {
    username = "dani";
    homeDirectory = "/home/dani"; 
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    packages = with pkgs; [
      mpv
      docker-compose
			brave
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };

  programs.home-manager.enable = true;
}
