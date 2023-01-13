# bspwm dotfiles
My own Ubuntu bspwm configuration

## Installation
### Clone the repository 
Make sure to have git and google chrome installed, or if you want another navigator,
```bash
cd ~/Downloads
git clone https://github.com/DaniFdz/dotfiles.git
cd dotfiles
```
### Install the dependencies
Install the above dependencies
```bash
sudo apt install zsh bspwm kitty neofetch picom rofi acpi bat feh
sudo snap install code --classic
sudo snap install nvim --classic
```

Download and compile [polybar](https://github.com/polybar/polybar/wiki/Compiling) from source

Download and compile [lsd](https://github.com/Peltoche/lsd) from source

### Copy configuration files
```bash
mkdir ~/.config
cp -r ./wallpapers ~/.wallpapers
cd config
cp -r bspwm/ kitty/ neofetch/ picom/ polybar/ rofi/ sxhkd/ ~/.config
cp ../zshrc ~/.zshrc
echo -e '#!/bin/bash\npicom -f &\nexec bspwm' > ~/.xinitrc
```
