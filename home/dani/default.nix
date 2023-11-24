{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ../capabilites/git
    ../capabilites/kitty
    ../capabilites/firefox
    ../capabilites/terminal
    ../capabilites/nvim
    ../capabilites/desktop
  ];

  fonts.fontconfig.enable = true;

  home = {
    username = "dani";
    homeDirectory = "/home/dani"; 
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    packages = with pkgs; [
      mpv
      docker-compose
    ];
  };

  programs.home-manager.enable = true;
}
