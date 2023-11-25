{ pkgs, ... }:

{
    imports = [
    ];

    wsl = {
      enable = true;
      wslConf = {
        automount.root = "/mnt";
        network.generateHosts = false;
      };
      defaultUser = "dani";
      startMenuLaunchers = true;
      nativeSystemd = true;
    };

    users.users.dani = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ];
      shell = pkgs.zsh;
    };

    virtualisation.docker.enable = true;

     # Enable nix flakes
    nix.package = pkgs.nixFlakes;
    nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';

    environment.systemPackages = with pkgs; [
      git
      zsh
      neovim
    ];

    system.stateVersion = "23.05";

  }
