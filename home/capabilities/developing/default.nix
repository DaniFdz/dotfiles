{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
		python311
		python311Packages.pip
		python311Packages.pip
		virtualenv
		cargo
		cargo-generate
		rustc
		gcc

		nodejs_21
  ];
}
