vim.g.copilot_no_tab_map = true;

vim.api.nvim_set_keymap("i", "<C-l>", "copilot#accept('<CR>')", {expr=true, silient=true})
vim.keymap.set("i", "<C-j>", "copilot#Next()", {expr=true, silient=true})
vim.keymap.set("i", "<C-k>", "copilot#Previous()", {expr=true, silient=true})
