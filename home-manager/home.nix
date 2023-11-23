{ config, pkgs, ... }:

{
  home.username = "dani";
  home.homeDirectory = "/home/dani";

  # targets.genericLinux.enable = true; # ENABLE THIS ON NON NIXOS

 home.stateVersion = "22.11"; 

  home.packages = with pkgs; [
    neovim
    zsh
    xclip
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;


  programs.git = {
    enable = true;
    userName = "DaniFdz";
    userEmail = "danifernandezzzzzz@gmail.com";
    aliases = {
    };
  };
  
  gtk = {
    enable = true;
    theme.name = "adw-gtk3";
    iconTheme.name = "GruvboxPlus";
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "neovide.desktop" ];
    "application/pdf" = [ "zathura.desktop" ];
    "image/*" = [ "sxiv.desktop" ];
    "video/png" = [ "mpv.desktop" ];
    "video/jpg" = [ "mpv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    envExtra = ''
      export TESTVARIABLE="something"
      [[ ! -f /home/dani/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "none9632/zsh-sudo"; }
        { name = "zdharma-continuum/fast-syntax-highlighting"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
  };

  programs.kitty = {
    enable = true;
  };
}
