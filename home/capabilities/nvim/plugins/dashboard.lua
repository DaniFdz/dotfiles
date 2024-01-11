local options

--math.randomseed( os.time() ) -- For random header.

-- To split our quote, artist and source.
-- And automatically center it for screen loader of the header.
local function split(s)
	local t               = {}
	local max_line_length = vim.api.nvim_get_option('columns')
	local longest         = 0 -- Value of longest string is 0 by default
	for far in s:gmatch("[^\r\n]+") do
		-- Break the line if it's actually bigger than terminal columns
		local line
		far:gsub('(%s*)(%S+)',
		function(spc, word)
			if not line or #line + #spc + #word > max_line_length then
				table.insert(t, line)
				line = word
			else
				line    = line..spc..word
				longest = max_line_length
			end
		end)
		-- Get the string that is the longest
		if (#line > longest) then
			longest = #line
		end
		table.insert(t, line)
	end
	-- Center all strings by the longest
	for i = 1, #t do
		local space = longest - #t[i]
		local left  = math.floor(space/2)
		local right = space - left
		t[i]        = string.rep(' ', left) .. t[i] .. string.rep(' ', right)
	end
	return t
end

-- Function to retrieve console output.
local function capture(cmd)
	local handle = assert(io.popen(cmd, 'r'))
	local output = assert(handle:read('*a'))
	handle:close()
	return output
end

-- Create button for initial keybind.
--- @param sc string
--- @param txt string
--- @param hl string
--- @param keybind string optional
local function button(sc, txt, keybind)
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

	local opts = {
		position       = "center",
		shortcut       = sc,
		cursor         = 5,
		width          = 50,
		align_shortcut = "right",
		hl_shortcut    = "keyword",
	}

	if keybind then
		opts.keymap = {"n", sc_, keybind, {noremap = true, silent = true, nowait = true}}
	end

	local function on_press()
		local key = vim.api.nvim_replace_termcodes(sc_ .. '<Ignore>', true, false, true)
		vim.api.nvim_feedkeys(key, "normal", false)
	end

	return {
		type     = "button",
		val      = txt,
		on_press = on_press,
		opts     = opts,
	}
end

-- All custom headers
Headers = {

	-- {
	-- 	[[            .-'''''-.    ]],
	-- 	[[          .'         `.  ]],
	-- 	[[         :             : ]],
	-- 	[[        :               :]],
	-- 	[[        :      _/|      :]],
	-- 	[[         :   =/_/      : ]],
	-- 	[[          `._/ |     .'  ]],
	-- 	[[       (   /  ,|...-'    ]],
	-- 	[[        \_/^\/||__       ]],
	-- 	[[     _/~  `""~`"` \_     ]],
	-- 	[[  __/  -'.  ` .  `\_\__  ]],
	-- 	[[/jgs     \           \-.\ ]],
	-- }, -- jgs

	-- {
	--  [[                                                                     ]],
	--  [[       ███████████           █████      ██                     ]],
	--  [[      ███████████             █████                             ]],
	--  [[      ████████████████ ███████████ ███   ███████     ]],
	--  [[     ████████████████ ████████████ █████ ██████████████   ]],
	--  [[    █████████████████████████████ █████ █████ ████ █████   ]],
	--  [[  ██████████████████████████████████ █████ █████ ████ █████  ]],
	--  [[ ██████  ███ █████████████████ ████ █████ █████ ████ ██████ ]],
	--  [[ ██████   ██  ███████████████   ██ █████████████████ ]],
	--  [[ ██████   ██  ███████████████   ██ █████████████████ ]],
	-- },

 -- {
 --   '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
 --   '⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡖⠁⠀⠀⠀⠀⠀⠀⠈⢲⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
 --   '⠀⠀⠀⠀⠀⠀⠀⠀⣼⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣧⠀⠀⠀⠀⠀⠀⠀⠀ ',
 --   '⠀⠀⠀⠀⠀⠀⠀⣸⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣇⠀⠀⠀⠀⠀⠀⠀ ',
 --   '⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⢀⣀⣤⣤⣤⣤⣀⡀⠀⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀ ',
 --   '⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣔⢿⡿⠟⠛⠛⠻⢿⡿⣢⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀ ',
 --   '⠀⠀⠀⠀⣀⣤⣶⣾⣿⣿⣿⣷⣤⣀⡀⢀⣀⣤⣾⣿⣿⣿⣷⣶⣤⡀⠀⠀⠀⠀ ',
 --   '⠀⠀⢠⣾⣿⡿⠿⠿⠿⣿⣿⣿⣿⡿⠏⠻⢿⣿⣿⣿⣿⠿⠿⠿⢿⣿⣷⡀⠀⠀ ',
 --   '⠀⢠⡿⠋⠁⠀⠀⢸⣿⡇⠉⠻⣿⠇⠀⠀⠸⣿⡿⠋⢰⣿⡇⠀⠀⠈⠙⢿⡄⠀ ',
 --   '⠀⡿⠁⠀⠀⠀⠀⠘⣿⣷⡀⠀⠰⣿⣶⣶⣿⡎⠀⢀⣾⣿⠇⠀⠀⠀⠀⠈⢿⠀ ',
 --   '⠀⡇⠀⠀⠀⠀⠀⠀⠹⣿⣷⣄⠀⣿⣿⣿⣿⠀⣠⣾⣿⠏⠀⠀⠀⠀⠀⠀⢸⠀ ',
 --   '⠀⠁⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⢇⣿⣿⣿⣿⡸⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠈⠀ ',
 --   '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
 --   '⠀⠀⠀⠐⢤⣀⣀⢀⣀⣠⣴⣿⣿⠿⠋⠙⠿⣿⣿⣦⣄⣀⠀⠀⣀⡠⠂⠀⠀⠀ ',
 --   '⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠉⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠋⠁⠀⠀⠀⠀⠀ ',
 -- },

 -- {
 --   [[=================     ===============     ===============   ========  ========]],
 --   [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
 --   [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
 --   [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
 --   [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
 --   [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
 --   [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
 --   [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
 --   [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
 --   [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
 --   [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
 --   [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
 --   [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
 --   [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
 --   [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
 --   [[||.=='    _-'                                                     `' |  /==.||]],
 --   [[=='    _-'                        N E O V I M                         \/   `==]],
 --   [[\   _-'                                                                `-_   /]],
 --   [[ `''                                                                      ``' ]],
 -- },

 -- {
 --   [[  ／|_       ]],
 --   [[ (o o /      ]],
 --   [[  |.   ~.    ]],
 --   [[  じしf_,)ノ ]],
 -- },

 -- {
 --   '          ▀████▀▄▄              ▄█ ',
 --   '            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ',
 --   '    ▄        █          ▀▀▀▀▄  ▄▀  ',
 --   '   ▄▀ ▀▄      ▀▄              ▀▄▀  ',
 --   '  ▄▀    █     █▀   ▄█▀▄      ▄█    ',
 --   '  ▀▄     ▀▄  █     ▀██▀     ██▄█   ',
 --   '   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ',
 --   '    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ',
 --   '   █   █  █      ▄▄           ▄▀   ',
 -- },

 {
   "                                                     ",
   "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
   "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
   "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
   "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
   "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
   "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
   "                                                     ",
 },

 -- {
 --   [[                               __                ]],
 --   [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
 --   [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
 --   [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
 --   [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
 --   [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
 -- },

}

--
-- Sections for Alpha.
--

local header = {
	type = "text",
	-- val = Headers[math.random(#Headers)],
	val = Headers[1],
	opts = {
		position = "center",
		hl       = "Type"
		-- wrap = "overflow";
	}
}

local footer = {
	type = "text",
	-- Change 'rdn' to any program that gives you a random quote.
	-- https://github.com/BeyondMagic/scripts/blob/master/quotes/rdn
	-- Which returns one to three lines, being each divided by a line break.
	-- Or just an array: { "I see you:", "Above you." }
	val = { "󰀘 " ..  vim.split(vim.api.nvim_exec("version", true), "\n", {})[2] },
	hl  = "NvimTreeRootFolder",
	opts = {
		position = "center",
		hl       = "rainbow1",
	}
}

local buttons = {
	type = "group",
	val = {
   button("ff","󰈞  Find file", ":Telescope find_files <CR>"),
   button("fr","󰁯  Recently used files", ":Telescope oldfiles <CR>"),
   button("ft","  Find text", ":Telescope live_grep <CR>"),
   button("t", "󱏒  Toggle Tree", ":NERDTreeToggle <CR>"),
   button("c", "  Edit configuration", ":cd ~/dotfiles | :e ~/dotfiles<CR>"),
   button("q", "  Quit Neovim", ":qa<CR>"),
	},
	opts = {
		spacing = 1,
	}
}

--
-- Centering handler of ALPHA
--

local ol = { -- occupied lines
	icon            = #header.val,            -- CONST: number of lines that your header will occupy
	message         = #footer.val,            -- CONST: because of padding at the bottom
	length_buttons  = #buttons.val * 2 - 1,   -- CONST: it calculate the number that buttons will occupy
	neovim_lines    = 2,                      -- CONST: 2 of command line, 1 of the top bar
	padding_between = 3,                      -- STATIC: can be set to anything, padding between keybinds and header
}

local left_terminal_value = vim.api.nvim_get_option('lines') - (ol.length_buttons + ol.message + ol.padding_between + ol.icon + ol.neovim_lines)

-- Not screen enough to run the command.
if (left_terminal_value >= 0) then

	local top_padding         = math.floor(left_terminal_value / 2)
	local bottom_padding      = left_terminal_value - top_padding

	--
	-- Set alpha sections
	--

	options = {
		layout = {
			{ type = "padding", val = top_padding },
			header,
			{ type = "padding", val = ol.padding_between },
			buttons,
			footer,
			{ type = "padding", val = bottom_padding },
		},
		opts = {
			margin = 5
		},
	}

end

require("alpha").setup(options)
