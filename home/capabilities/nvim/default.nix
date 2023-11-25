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
      luajitPackages.lua-lsp
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
    '';

    plugins = with pkgs.vimPlugins; [
      # Look for packages: nix-env -f '<nixpkgs>' -qaP -A vimPlugins
      # {
      #   plugin = tokyonight-nvim;
      #   config = "colorscheme tokyonight-moon";
      # }	
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
      {
        plugin = telescope-nvim;
        config = toLuaFile ./plugins/telescope.lua;
      }
      {
        plugin = nerdtree;
        config = toLuaFile ./plugins/nerdtree.lua;
      }
      {
        plugin = cmp-copilot;
        config = toLuaFile ./plugins/copilot.lua;
      }
      {
        plugin = lualine-nvim;
        config = toLuaFile ./plugins/lualine.lua;
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
      {
        plugin = nvim-treesitter.withAllGrammars;
        config = toLuaFile ./plugins/treesitter.lua;
      }
    ];
  };
}
