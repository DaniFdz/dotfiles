{ pkgs, ... }:

{
  home.packages = with pkgs; [
		act
	];

  programs.git = {
    enable = true;
    userName = "DaniFdz";
    userEmail = "danifernandezzzzzz@gmail.com";
  };

  programs.gh.enable = true;
}
