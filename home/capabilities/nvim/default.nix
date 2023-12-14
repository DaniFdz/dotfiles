{ config, pkgs, ... }:

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
      rnix-lsp
      emmet-ls
      rust-analyzer
      luajitPackages.lua-lsp
			vscode-langservers-extracted
			nodePackages.pyright
			nodePackages.typescript-language-server
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
    '';

    plugins = with pkgs.vimPlugins; [
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
        plugin = rust-tools-nvim;
        config = toLuaFile ./plugins/rust-tools.lua;
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
    ];
  };
}
