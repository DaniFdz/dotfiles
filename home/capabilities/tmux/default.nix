{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    terminal = "screen-256color";
    prefix = "C-a";
    shortcut = "a";
    mouse = true;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      # List available plugins: nix-env -f '<nixpkgs>' -qaP -A tmuxPlugins
      vim-tmux-navigator
			tmux-fzf
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
      }
      {
        plugin = continuum;
        extraConfig = ''
        set -g @continuum-restore 'on'
        set -g @continuum-save-interval '15'
        '';
      }
      {
        plugin = catppuccin;
        extraConfig = "set -g @catppuccin_flavour 'macchiato'";
      }
    ];
    extraConfig = ''
    ${builtins.readFile ./tmux.conf}
    '';
  };
  
}
