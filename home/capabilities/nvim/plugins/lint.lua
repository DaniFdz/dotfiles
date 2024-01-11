vim.g.leader = ' '
vim.g.mapleader = ' '

local null_ls = require('null-ls') -- none-ls.nvim
local b = null_ls.builtins

null_ls.setup({
	sources = {
		b.diagnostics.flake8,
		b.diagnostics.eslint_d,
		b.diagnostics.hadolint,
		b.diagnostics.luacheck,
		b.formatting.stylelua,
		b.formatting.black,
		b.formatting.isort,
		b.formatting.prettier,
		b.formatting.rustfmt,
	},
})

vim.api.nvim_set_keymap('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
