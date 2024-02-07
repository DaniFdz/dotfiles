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

		nodejs_20
		corepack_20
		bun

		mysql80
		mongodb-compass
  ];
}
