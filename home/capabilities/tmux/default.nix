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
        extraConfig = ''
				set -g @catppuccin_flavour "macchiato"
				set -g @catppuccin_window_right_separator "█ "
				set -g @catppuccin_window_number_position "right"
				set -g @catppuccin_window_middle_separator " | "

				set -g @catppuccin_window_default_fill "none"

				set -g @catppuccin_window_current_fill "all"

				set -g @catppuccin_status_modules_right "application session user host date_time"
				set -g @catppuccin_status_left_separator "█"
				set -g @catppuccin_status_right_separator "█"

				set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M:%S"
				'';
      }
    ];
    extraConfig = ''
    ${builtins.readFile ./tmux.conf}
    '';
  };
  
}
