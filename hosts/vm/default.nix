{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
		minegrub-theme = {
			enable = true;
			splash = "100 Flakes!";
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

  networking.hostName = "dani"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system
  services.xserver = {
    layout = "es,us";
    xkbVariant = "grp:alt_shift_toggle";
    enable = true;
    displayManager.gdm = {
      enable = true;
      # wayland = true;
    };
    # windowManager.awesome.enable = true;
    desktopManager.gnome.enable = true;
		libinput = {
			enable = true;
			touchpad = {
				tapping = true;
				naturalScrolling = true;
				scrollMethod = "twofinger";
				disableWhileTyping = false;
				clickMethod = "clickfinger";
				buttonMapping = "1 3 2";
			};
		};
		exportConfiguration = true;
  };

  console.useXkbConfig = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

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
		keepassxc
		syncthing
    pavucontrol
    pulseaudio
  ];
  
  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  virtualisation = {
    # Enable VMware tools
    vmware.guest.enable = true;

    docker.enable = true;
  };

  programs.dconf.enable = true;

  system.stateVersion = "23.05";
}
