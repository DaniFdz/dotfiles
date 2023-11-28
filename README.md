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

## For NixOS systems
Enable flakes
```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
```
Rebuild system with specific configurations
```bash
sudo nixos-rebuild switch --flake github:DaniFdz/dotfiles#gnome
```

## For non NixOS systems
Download NixOS
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

To build the system, open a new terminal and type
```bash
nix --experimental-features 'nix-command flakes' build -L github:DaniFdz/dotfiles#nixosConfigurations.gnome.config.system.build.toplevel
```
