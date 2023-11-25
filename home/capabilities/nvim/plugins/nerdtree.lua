local keymap = function(shortcut, command) 
  vim.api.nvim_set_keymap('n', shortcut, command, { noremap = true, silent = true })
end

keymap('<leader>d', ':NvimTreeToggle<cr>')
