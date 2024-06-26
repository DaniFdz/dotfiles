vim.g.leader = ' '
vim.g.mapleader = ' '

local null_ls = require('null-ls') -- none-ls.nvim
local b = null_ls.builtins

null_ls.setup({
	sources = {
		-- Python3
		b.diagnostics.flake8,
		b.formatting.black,
		b.formatting.isort,

		-- Js
		b.diagnostics.eslint,
		b.formatting.prettier,

		-- Lua
		b.diagnostics.luacheck,

		-- Rust
		b.formatting.rustfmt,

		-- Docker
		b.diagnostics.hadolint,

		-- Shell
		b.diagnostics.shellcheck,
		b.formatting.shfmt,

		-- Nix
		b.diagnostics.deadnix,
		b.formatting.nixfmt,
		b.diagnostics.statix,
		b.code_actions.statix,

		-- Go
		b.formatting.gofumpt,
		b.formatting.goimports_reviser,
		b.formatting.golines
	},
})

vim.api.nvim_set_keymap('n', '<leader>cf', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
