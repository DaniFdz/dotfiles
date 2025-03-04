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

function CopyRelativePath()
  local relative_path = vim.fn.expand("%")
  vim.fn.setreg("+", relative_path)
  print("Copied relative path: " .. relative_path)
end
map(
  { "n" },
  "<leader>yr",
  ":lua CopyRelativePath()<CR>",
  { desc = "Copy relative path", silent = true, noremap = true }
)
function CopyFullPath()
  local full_path = vim.fn.expand("%:p")
  vim.fn.setreg("+", full_path)
  print("Copied full path: " .. full_path)
end
map({ "n" }, "<leader>yp", ":lua CopyFullPath()<CR>", { desc = "Copy full pathh", silent = true, noremap = true })

map(
  { "n", "v" },
  "<leader>a",
  "<cmd>CodeCompanionActions<CR>",
  { desc = "Open the action palette", silent = true, noremap = true }
)
map(
  { "n", "v" },
  "<leader>ct",
  "<cmd>CodeCompanionChat Toggle<CR>",
  { desc = "Toggle a chat buffer", silent = true, noremap = true }
)
map(
  { "n", "v" },
  "ga",
  "<cmd>CodeCompanionChat Add<CR>",
  { desc = "Add selected text to a chat buffer", silent = true, noremap = true }
)
