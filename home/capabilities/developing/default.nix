{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
		shellcheck

		python311
		python311Packages.pip
		python311Packages.virtualenv
		poetry

		rustc
		cargo
		cargo-generate
		rustfmt
		rust-analyzer

		gcc

		nodejs_20
		corepack_20
		bun

		mysql80
		mongodb-compass
		redis
  ];
}
