# NixOS home-manager dotfiles

<p align="center">
    <a href="https://nixos.org/">
        <img src="https://img.shields.io/badge/NixOS-23.05-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41">
    </a>
    <a href="https://github.com/ryan4yin/nix-config/stargazers">
		<img alt="Stargazers" src="https://img.shields.io/github/stars/DaniFdz/dotfiles?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41">
	</a>
    <img src="https://img.shields.io/static/v1?label=Nix&message=Works on my machine&style=for-the-badge&logo=linux&color=ADC6F2&logoColor=D9E0EE&labelColor=302D41"/>
</p>

---

To install just add this line to `/etc/nixos/configuration-nix`:
```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

And then type:
```
sudo nixos-rebuild switch

git clone https://github.com/DaniFdz/dotfiles.git && cd dotfiles
home-manager switch --flake .
```
