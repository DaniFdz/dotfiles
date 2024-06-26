{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    zsh
    zip
    unzip
    p7zip
    xclip
    zoxide # Better cd
    jq # JSON parser
    bc # Calculator
    lsd # Better ls
    sd # Better syntax for sed command
    fd # Better syntax for find command
    delta # Git diff
    tokei # Count lines of code
    just # Makefile alternative
    glow # Markdown preview
    lazydocker # Docker UI
    ripgrep # Better grep
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      ll = "lsd -lh --group-dirs=first";
      la = "lsd -a --group-dirs=first";
      l = "lsd --group-dirs=first";
      lla = "lsd -lha --group-dirs=first";
      ls = "lsd --group-dirs=first";
      cat = "bat -P --theme=Dracula";
      catl = "bat --theme=Dracula";
      catn = "/run/current-system/sw/bin/cat";
      python = "python3";
      py = "python3";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
			gr = "git restore";
			gcl	= "git clone";
      pdw = "pwd";
      naut = "nautilus";
      tb = "nc termbin.com 9999";
      code = "code --enable-features=UseOzonePlatform --ozone-platform=x11 &>/dev/null";
      n = "nvim";
      v = "nvim";
      b = "bun";
      bx = "bunx";
      p = "pnpm";
      px = "pnpx";
    };
    initExtra = ''
      			[[ ! -f /home/dani/.p10k.zsh ]] || source ~/.p10k.zsh
      			[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

      			# configure key keybindings
      			bindkey -e                                        # emacs key bindings
      			bindkey ' ' magic-space                           # do history expansion on space
      			bindkey '^[[3;5~' kill-word                       # ctrl + Supr
      			bindkey '^[[3~' delete-char                       # delete
      			bindkey '^[[1;5C' forward-word                    # ctrl + ->
      			bindkey '^[[1;5D' backward-word                   # ctrl + <-
      			bindkey '^[[5~' beginning-of-buffer-or-history    # page up
      			bindkey '^[[6~' end-of-buffer-or-history          # page down
      			bindkey '^[[H' beginning-of-line                  # home
      			bindkey '^[[F' end-of-line                        # end
      			bindkey '^[[Z' undo
      			bindkey '[C' forward-word
      			bindkey '[D' backward-word
      			bindkey '^H' backward-kill-word
      			bindkey "\e[3;5~" kill-word
      			bindkey "\e[3~" delete-char
      			bindkey "\e[H"  beginning-of-line
      			bindkey "\e[F"  end-of-line
						bindkey -s ^f "tmux-sessionizer.sh\n"

      			export EDITOR="nvim"
						export PATH=$PATH:$HOME/.cargo/bin
						export PATH=$PATH:$HOME/.local/bin
						export PATH=$PATH:$HOME/.config/scripts
						export PATH=$PATH:$HOME/.mutable_node_modules/bin


						if [ ! -d "$HOME/.mutable_node_modules" ]; then
							npm config set prefix '~/mutable_node_modules'
						fi

						if [ -f "/etc/wsl.conf" ]; then
							export BROWSER="/mnt/c/Program\ Files/BraveSoftware/Brave-Browser/Application/brave.exe";

							alias cc="clip.exe";
						else
							export BROWSER="brave";

							alias cc="wl-copy"
						fi

						eval "$(zoxide init zsh)"
    '';

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "none9632/zsh-sudo"; }
        { name = "zdharma-continuum/fast-syntax-highlighting"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
    themes = {
      dracula = {
        src = pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "sublime"; # Bat uses sublime syntax for its themes
          rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
          sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
        };
        file = "Dracula.tmTheme";
      };
    };
  };

  home.file.".gitconfig".text = ''# https://dandavison.github.io/delta/introduction.html
[core]
    pager = delta
[interactive]
    diffFilter = delta --color-only
[delta]
    navigate = true    # use n and N to move between diff sections
    light = false      # set to true if you're in a terminal w/ a light background color (e.g. the default macOS terminal)
		line-numbers = true
		side-by-side = true
[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default'';
}
