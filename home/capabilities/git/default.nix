{ pkgs, ... }:

{
  home.packages = with pkgs; [
		subversionClient
		act
	];

  programs.git = {
    enable = true;
    userName = "DaniFdz";
    userEmail = "danifernandezzzzzz@gmail.com";
  };

  programs.gh.enable = true;
}
