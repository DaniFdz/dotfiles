{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ../capabilities/git
    ../capabilities/hacking
    ../capabilities/alacritty
    ../capabilities/kitty
    ../capabilities/terminal
    ../capabilities/nvim
    ../capabilities/tmux
    ../capabilities/desktop
		../capabilities/developing
		../capabilities/zathura
		../capabilities/vscode
  ];

  fonts.fontconfig.enable = true;

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

	home.file.".config/hypr/configs/monitors.conf" = { source = ./monitors.conf; recursive = true; };

  home = {
    username = "dani";
    homeDirectory = "/home/dani"; 
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.11";
    packages = with pkgs; [
      mpv
      docker-compose
			brave
			font-awesome
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    ];
  };


  programs.home-manager.enable = true;
}
