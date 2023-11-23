# NixOS home-manager dotfiles

To install just add this line to `/etc/nixos/configuration-nix`:
```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

And then type:
```
sudo nixos-rebuild switch
home-manager switch --flake .
```
