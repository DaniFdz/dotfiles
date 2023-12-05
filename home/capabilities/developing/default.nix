{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
		python311
		python311Packages.pip
		cargo
		cargo-generate
		rustc
		gcc
  ];
}
