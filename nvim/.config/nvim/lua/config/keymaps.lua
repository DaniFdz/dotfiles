-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

map({ "n" }, "<leader>gg", ":OpenInGHRepo <CR>", { desc = "Open in GitHub Repo", silent = true, noremap = true })
map({ "n" }, "<leader>gf", ":OpenInGHFile <CR>", { desc = "Open in GitHub File", silent = true, noremap = true })
map(
  { "v" },
  "<leader>gf",
  ":OpenInGHFileLines <CR>",
  { desc = "Open in GitHub File Lines", silent = true, noremap = true }
)
