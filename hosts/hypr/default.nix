{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    devices = ["nodev"];
    efiSupport = true;
    useOSProber = true;
    dedsec-theme = {
      enable = true;
      style = "redskull";
      icon = "color";
      resolution = "1080p";
    };
  };

  boot.plymouth = {
    enable = true;
    font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
    themePackages = [ pkgs.catppuccin-plymouth ];
    theme = "catppuccin-macchiato";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than-1w";
  };

  networking.hostName = "dani"; 
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  time.timeZone = "Europe/Madrid";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  services.xserver = {
    enable = true;
    layout = "es,us";
    xkbVariant = "grp:alt_shift_toggle";
  };

  console.useXkbConfig = true;

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.libinput.enable = true;

  environment.shells = [ pkgs.zsh ];
  programs.zsh.enable = true;

  users.users.dani = {
    isNormalUser = true;
    description = "dani";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };
  
  environment.systemPackages = with pkgs; [
    git
    vim
    file
    wget
    curl
    discord
    pavucontrol
    pulseaudio
  ];
  
  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  virtualisation = {
    # Enable VMware tools

    docker.enable = true;
  };

  programs.dconf.enable = true;


  system.stateVersion = "23.05"; # Did you read the comment?
}

