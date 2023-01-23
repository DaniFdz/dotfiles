# BSPWM and polybar dotfiles
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
sudo apt install zsh bspwm kitty neofetch picom rofi acpi bat feh net-tools x11-xkb-utils
sudo snap install code --classic
sudo snap install nvim --classic
```

Download and compile [polybar](https://github.com/polybar/polybar/wiki/Compiling) from source

Download and compile [lsd](https://github.com/Peltoche/lsd) from source

Download p10k
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```

### Configuration files
```bash
mkdir ~/.config
cp -r ./wallpapers ~/.wallpapers
cd config
cp -r bspwm/ kitty/ neofetch/ picom/ polybar/ rofi/ sxhkd/ ~/.config
cp ../zshrc ~/.zshrc
echo -e '#!/bin/bash\npicom -f &\nexec bspwm' > ~/.xinitrc
```

Make zsh the default shell
```bash
chsh -s $(which zsh)
```
