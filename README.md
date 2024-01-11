# NixOS home-manager dotfiles

<p align="center">
    <img src="./assets/Desktop.png">
</p>

<p align="center">
    <a href="https://nixos.org/">
        <img src="https://img.shields.io/badge/NixOS-23.05-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41">
    </a>
    <a href="https://github.com/DaniFdz/dotfiles/stargazers">
		<img alt="Stargazers" src="https://img.shields.io/github/stars/DaniFdz/dotfiles?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41">
	</a>
    <img src="https://img.shields.io/static/v1?label=Nix&message=Works on my machine&style=for-the-badge&logo=linux&color=ADC6F2&logoColor=D9E0EE&labelColor=302D41"/>
</p>

---

## For NixOS systems
Enable flakes:
```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
```
Rebuild system with specific configurations:
```bash
sudo nixos-rebuild switch --flake github:DaniFdz/dotfiles#gnome
```

## For wsl NixOS
First download the [latest release](https://github.com/nix-community/NixOS-WSL/releases/tag/23.5.5.2)

Then open a terminal and run:
```ps1
wsl --import NixOS .\NixOS\ nixos-wsl.tar.gz --version 2
wsl -d NixOS
```

After the initial installation, you need to update your channels once, to be able to use `nixos-rebuild`:
```bash
nix-channel --update
```

To build the system type:
```bash
nixos-rebuild switch --flake github:DaniFdz/dotfiles#wsl
```

