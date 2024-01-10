require("neorg").setup {
	load = {
		["core.defaults"] = {}, -- Loads default behaviour
		["core.concealer"] = {}, -- Adds pretty icons to your documents
		["core.summary"] = {},
		["core.completion"] = {
			config = {
				engine = "nvim-cmp"
			}
		},
		["core.dirman"] = { -- Manages Neorg workspaces
			config = {
				workspaces = {
					notes = "~/Documents/notes",
					uni = "~/Documents/notes/uni",
				},
			},
		},
	},
}
