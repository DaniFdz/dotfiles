{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
		shellcheck

		python311
		python311Packages.pip
		python311Packages.mypy
		python311Packages.flake8
		python311Packages.black
		python311Packages.virtualenv
		poetry

		rustc
		cargo
		cargo-generate
		cargo-watch
		cargo-audit
		rustfmt
		rust-analyzer
		clippy

		gcc

		nodejs_20
		corepack_20
		bun

		mysql80
		mongodb-compass
		redis
  ];
}
