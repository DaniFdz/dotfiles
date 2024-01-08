{ pkgs, ... }:

{
  imports = [
    ../hacking_min
  ];

  home.packages = with pkgs; [ 
		burpsuite
		wireshark
  ];
}
