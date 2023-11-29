{
  description = "Dani Fdz's Dotfiles";

  nixConfig.experimental-features = [ "nix-command" "flakes" ];

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    NixOS-WSL = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		dedsec-grub-theme = {
			url = gitlab:VandalByte/dedsec-grub-theme;
      inputs.nixpkgs.follows = "nixpkgs";
		};
  };

  outputs = { self, nixpkgs, home-manager, NixOS-WSL, dedsec-grub-theme, ... }@inputs:
    let
      inherit (self) outputs;
    in {
      nixosConfigurations = {
        # By default, NixOS will try to refer the nixosConfiguration with its hostname.
        # so the system named `nixos-test` will use this configuration.
        # However, the configuration name can also be specified using `sudo nixos-rebuild switch --flake /path/to/flakes/directory#<name>`.
        # The `nixpkgs.lib.nixosSystem` function is used to build this configuration, the following attribute set is its parameter.
        # Run `sudo nixos-rebuild switch --flake .#nixos-test` in the flake's directory to deploy this configuration on any NixOS system  
        gnome = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };  # pass custom arguments into sub module.
          modules = [
            ./hosts/gnome
						dedsec-grub-theme.nixosModule
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.dani = import ./home/gnome;
            }
          ];
        };
        hypr = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };  # pass custom arguments into sub module.
          modules = [
            ./hosts/hypr
            dedsec-grub-theme.nixosModule
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.dani = import ./home/hypr;
            }
          ];
        };
        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { nix.registry.nixpkgs.flake = nixpkgs; }
            ./hosts/wsl
            NixOS-WSL.nixosModules.wsl
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.dani = import ./home/wsl;
            }
          ];
        };
      };
    };

}
