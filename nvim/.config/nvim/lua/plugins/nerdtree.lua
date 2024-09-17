return {
		"preservim/nerdtree", name = "nerdtree",
    dependencies = {
      "Xuyuanp/nerdtree-git-plugin",
      "tiagofumo/vim-nerdtree-syntax-highlight",
      "ryanoasis/vim-devicons",
    },
		config = function()
      vim.g.NERDTreeShowHidden=1

      vim.api.nvim_set_keymap('n', '<leader>t', ':NERDTreeToggle<cr>', { noremap = true, silent = true })
		end,
	}
