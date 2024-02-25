local harpoon = require("harpoon")

harpoon.setup({
	settings = {
		save_on_toggle = true,
		sync_on_ui_close = true;
	},
})

-- Toggle Harpoon menu
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end
vim.keymap.set("n", "<leader>hh", function() toggle_telescope(require("harpoon"):list()) end)
-- Toggle current file in Harpoon
vim.keymap.set("n", "<leader>ht", function()
	local list = require("harpoon"):list()
	local buf_name = vim.fn.expand("%")
	if list:get_by_display(buf_name) == nil then
		list:append()
	else
		list:remove()
	end
end)
-- Append current file to Harpoon
vim.keymap.set("n", "<leader>ha", function() require("harpoon"):list():append() end)
-- Remove current file from Harpoon
vim.keymap.set("n", "<leader>hr", function() require("harpoon"):list():remove() end)
-- Clear harpoon list
vim.keymap.set("n", "<leader>hc", function() require("harpoon"):list():clear() end)
-- Go to next harpoon entry
vim.keymap.set("n", "<leader>hn", function() require("harpoon"):list():next() end)
-- Go to previous harpoon entry
vim.keymap.set("n", "<leader>hp", function() require("harpoon"):list():prev() end)
-- Go to a custom harpoon entry
for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, function() require("harpoon"):list():select(i) end)
end
