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
    programs.zsh.enable = true;

    virtualisation.docker.enable = true;

     # Enable nix flakes
    nix.package = pkgs.nixFlakes;
		nixpkgs.config.allowUnfree = true;
    nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';

    environment.systemPackages = with pkgs; [
      git
      wget
      neovim
    ];

    system.stateVersion = "23.05";

		systemd.user = {
		paths.vscode-remote-workaround = {
			wantedBy = ["default.target"];
			pathConfig.PathChanged = "%h/.vscode-server/bin";
		};

		services.vscode-remote-workaround.script = ''
			for i in ~/.vscode-server/bin/*; do
				echo "Fixing vscode-server in $i..."
				ln -sf ${pkgs.nodejs_18}/bin/node $i/node
			done
		'';
		};
  }
