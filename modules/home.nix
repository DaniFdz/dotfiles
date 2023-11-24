{ pkgs, inputs, ... }:

{
  home.username = "dani";
  home.homeDirectory = "/home/dani";
  
  imports = [
    ./kitty.nix
    ./hyprland.nix
    ../common/terminal.nix
    ../common/nvim.nix
  ];

  # targets.genericLinux.enable = true; # ENABLE THIS ON NON NIXOS

  home.stateVersion = "22.11"; 

  home.packages = with pkgs; [
    neovide
    sxiv
    mpv
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
  };

  programs.gh.enable = true;
  
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

  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      settings = {
        "browser.startup.homepage" = "about:blank";
      };
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        darkreader
        ublock-origin
      ];
      bookmarks = [
        {
          name = "YouTube";
          url = "www.youtube.com";
        }
        {
          name = "YouTube Music";
          url = "www.music.youtube.com";
        }
        {
          name = "Calendar";
          url = "calendar.google.com";
        }
        {
          name = "Google Drive";
          url = "drive.google.com";
        }
        {
          name = "Deepl Translate";
          url = "www.deepl.com/es/translator";
        }
        {
          name = "Home-manager bible";
          url = "https://rycee.gitlab.io/home-manager/options.html";
        }
      ];
    };
  };

  programs.zathura = {
    enable = true;
    options = {
      default-bg = "#1a1b26";
      default-fg = "#d5d6db";
    };
  };
}
