{ config, pkgs, inputs, ... }:

{
  programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraPackages = with pkgs; [
        lua-language-server
        rnix-lsp
        emmet-ls
        rust-analyzer
        python311Packages.flake8
        python311Packages.black
        python311Packages.isort
        luajitPackages.lua-lsp
        luajitPackages.luacheck
        vscode-langservers-extracted
        nodePackages.pyright
        nodePackages_latest.prettier
        nodePackages.typescript-language-server
        tailwindcss-language-server
        rustfmt
        stylua
        nodePackages_latest.eslint
        hadolint
        shellcheck
        shfmt
        deadnix
        nixfmt
        statix
      ];

      extraLuaConfig = ''
        ${builtins.readFile ./options.lua}
      '';

      plugins = with pkgs.vimPlugins;
        let
          obsidian = pkgs.vimUtils.buildVimPlugin {
            name = "obsidian";
            src = inputs.obsidian;
          };
          none-ls-nvim = pkgs.vimUtils.buildVimPlugin {
            name = "none-ls-nvim";
            src = inputs.none-ls;
          };
          telescope-emoji = pkgs.vimUtils.buildVimPlugin {
            name = "telescope-emoji";
            src = inputs.telescope-emoji;
          };
          harpoon2 = pkgs.vimUtils.buildVimPlugin {
            name = "harpoon2";
            src = inputs.harpoon2;
          };
        in
        [
          # Look for packages: nix-env -f '<nixpkgs>' -qaP -A vimPlugins
          {
            plugin = catppuccin-nvim;
            config = toLuaFile ./plugins/catppuccin.lua;
          }

          {
            plugin = comment-nvim;
            config = toLua "require(\"Comment\").setup()";
          }

          {
            plugin = blamer-nvim;
            config = toLua "vim.g.blamer_enabled = 1";
          }

          {
            plugin = nvim-lspconfig;
            config = toLuaFile ./plugins/lsp.lua;
          }
          {
            plugin = nvim-cmp;
            config = toLuaFile ./plugins/cmp.lua;
          }
          luasnip
          neodev-nvim
          cmp_luasnip
          cmp-nvim-lsp

          {
            plugin = nerdtree;
            config = toLuaFile ./plugins/nerdtree.lua;
          }
          nerdtree-git-plugin
          vim-nerdtree-syntax-highlight
          vim-devicons

          {
            plugin = cmp-copilot;
            config = toLuaFile ./plugins/copilot.lua;
          }

          {
            plugin = lualine-nvim;
            config = toLuaFile ./plugins/lualine.lua;
          }


          {
            plugin = vimtex;
            config = toLuaFile ./plugins/vimtex.lua;
          }

          vim-tmux-navigator
          colorizer

          {
            plugin = nvim-treesitter.withAllGrammars;
            config = toLuaFile ./plugins/treesitter.lua;
          }

          {
            plugin = none-ls-nvim;
            config = toLuaFile ./plugins/lint.lua;
          }

          {
            plugin = telescope-nvim;
            config = toLuaFile ./plugins/telescope.lua;
          }
          telescope-media-files-nvim
          telescope-fzf-native-nvim
          telescope-file-browser-nvim
          telescope-ui-select-nvim
          telescope-emoji

          nui-nvim
          {
            plugin = nvim-notify;
            config = toLuaFile ./plugins/notify.lua;
          }
          {
            plugin = noice-nvim;
            config = toLuaFile ./plugins/noice.lua;
          }

          {
            plugin = goto-preview;
            config = toLuaFile ./plugins/goto-preview.lua;
          }

          plenary-nvim
          {
            plugin = neorg;
            config = toLuaFile ./plugins/neorg.lua;
          }
          {
            plugin = obsidian;
            config = toLuaFile ./plugins/obsidian.lua;
          }

          {
            plugin = nvim-cursorline;
            config = toLuaFile ./plugins/cursorline.lua;
          }

          {
            plugin = bufferline-nvim;
            config = toLuaFile ./plugins/bufferline.lua;
          }
          nvim-web-devicons

          {
            plugin = FTerm-nvim;
            config = toLuaFile ./plugins/fterm.lua;
          }

          vim-fugitive

          {
            plugin = alpha-nvim;
            config = toLuaFile ./plugins/dashboard.lua;
          }

          # {
          # 	plugin = harpoon;
          # 	config = toLuaFile ./plugins/harpoon.lua;
          # }

          {
            plugin = vim-astro;
            config = toLua "vim.g.astro_typescript = 'enable'";
          }

          vim-wakatime

					{
						plugin = harpoon2;
						config = toLuaFile ./plugins/harpoon.lua;
					}

        ];
    };
}
