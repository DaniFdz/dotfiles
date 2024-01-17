{ pkgs, ... }:

{
  home.packages = with pkgs; [ 
		openvpn
		nmap
		wfuzz
		gobuster
		john
		whatweb
  ];
}
