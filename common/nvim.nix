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
				plugin = dracula-nvim;
				config = "colorscheme dracula";
			}	

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./nvim/plugin/lsp.lua;
      }

			{
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

			nvim-web-devicons

			vim-nix
		];
 
    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
    '';
  };
}
