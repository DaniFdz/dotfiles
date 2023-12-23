vim.g.mapleader = ' ' 
vim.g.maplocalleader = ' '

local keymap = function(shortcut, command) 
  vim.api.nvim_set_keymap('n', shortcut, command, { noremap = true, silent = true })
end

vim.g.NERDTreeShowHidden=1

keymap('<leader>t', ':NERDTreeToggle<cr>')
