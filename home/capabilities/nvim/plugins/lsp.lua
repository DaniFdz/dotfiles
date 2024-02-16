vim.g.leader = " "
vim.g.mapleader = " "

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


local on_attach = function(_, bufnr)
	local bufmap = function(shortcut, command)
		vim.keymap.set("n", shortcut, command, { buffer = bufnr })
	end

	bufmap("gD", vim.lsp.buf.declaration)
	bufmap("gd", vim.lsp.buf.definition)
	bufmap("K", vim.lsp.buf.hover)
	bufmap("gi", vim.lsp.buf.implementation)
	bufmap("gr", vim.lsp.buf.references)
	bufmap("<leader>k", vim.lsp.buf.signature_help)
	bufmap("<leader>wa", vim.lsp.buf.add_workspace_folder)
	bufmap("<leader>wr", vim.lsp.buf.remove_workspace_folder)
	bufmap("<leader>wl", vim.lsp.buf.list_workspace_folders)
	bufmap("<leader>D", vim.lsp.buf.type_definition)
	bufmap("<leader>rn", vim.lsp.buf.rename)
	bufmap("<leader>ca", vim.lsp.buf.code_action)
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, {})
end

require("neodev").setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	settings = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
			},
		},
	},
})

local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "astro" },
})

lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.rnix.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
