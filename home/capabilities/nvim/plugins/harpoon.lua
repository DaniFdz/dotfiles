local harpoon = require("harpoon")

vim.api.nvim_set_keymap("n", "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
	{ noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>",
	{ noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>hd", "<cmd>lua require('harpoon.mark').remove_file()<cr>",
	{ noremap = true, silent = true })
for i = 1, 9 do
	vim.api.nvim_set_keymap("n", "<leader>h" .. i, "<cmd>lua require('harpoon.ui').nav_file(" .. i .. ")<cr>",
		{ noremap = true, silent = true })
end
vim.api.nvim_set_keymap("n", "<leader>hr", "<cmd>lua require('harpoon.ui').reset()<cr>",
	{ noremap = true, silent = true })

harpoon.setup({
	global_settings = {
		save_on_change = true,
	},
})
