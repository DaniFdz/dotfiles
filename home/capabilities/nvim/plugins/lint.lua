require('lint').linter_by_ft = {
	python = {'flake8'},
	javascript = {'eslint_d'},
	typescript = {'eslint_d'},
	zsh = {'zsh'},
	dockerfile = {'hadolint'},
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
