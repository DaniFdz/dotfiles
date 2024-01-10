vim.opt.termguicolors = true
require("bufferline").setup{
	options = {
		numbers = "ordinal",
		middle_mouse_command = "bdelete! %d",
		diagnostics = "nvim_lsp",
		color_icons = true,
		separators = "",
		indicator_icon = '▎',
		buffer_close_icon = '',
		modified_icon = '●',
		close_icon = '',
		left_trunc_marker = '',
		right_trunc_marker = '',
		max_name_length = 18,
		max_prefix_length = 15,
		tab_size = 18,
		show_buffer_close_icons = true,
		show_close_icon = false,
		show_tab_indicators = true,
		show_buffer_icons = true,
		sort_by = 'insert_at_end',
		separator_style = "thick",
		hover = {
				enabled = true,
				delay = 150,
				reveal = {'close'}
			}
	}
}
		
