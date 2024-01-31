{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
		python311
		python311Packages.pip
		python311Packages.virtualenv
		poetry

		cargo
		cargo-generate
		rustc
		gcc

		nodejs_21
		corepack_21
		bun

		mongodb-compass
  ];
}
