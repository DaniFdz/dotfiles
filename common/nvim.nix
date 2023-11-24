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

    plugins = with pkgs.vimPlugins; [
      # Look for packages: nix-env -f '<nixpkgs>' -qaP -A vimPlugins

      {
        plugin = tokyonight-nvim;
        config = "colorscheme tokyonight-moon";
      }	

      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./nvim/plugins/lsp.lua;
      }

      {
        plugin = nvim-cmp;
        config = toLuaFile ./nvim/plugins/cmp.lua;
      }
      
      {
        plugin = telescope-nvim;
        config = toLuaFile ./nvim/plugins/telescope.lua;
      }

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        config = toLuaFile ./nvim/plugins/treesitter.lua;
      }

      telescope-fzf-native-nvim

      cmp_luasnip

      cmp-nvim-lsp

      luasnip

      friendly-snippets

      lualine-nvim

      nvim-web-devicons

      neodev-nvim

      vim-nix
    ];
 
    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
    '';
  };
}
