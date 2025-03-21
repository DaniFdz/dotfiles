return {
  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
  },

  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    cond = vim.g.neovide == nil,
    opts = function(_, opts)
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "grug-far",
        callback = function()
          vim.b.minianimate_disable = true
        end,
      })

      Snacks.toggle({
        name = "Mini Animate",
        get = function()
          return not vim.g.minianimate_disable
        end,
        set = function(state)
          vim.g.minianimate_disable = not state
        end,
      }):map("<leader>ua")

      local animate = require("mini.animate")
      return vim.tbl_deep_extend("force", opts, {
        resize = {
          timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
      })
    end,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    init = false,
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[


                                              
       ████ ██████           █████      ██
      ███████████             █████ 
      █████████ ███████████████████ ███   ███████████
     █████████  ███    █████████████ █████ ██████████████
    █████████ ██████████ █████████ █████ █████ ████ █████
  ███████████ ███    ███ █████████ █████ █████ ████ █████
 ██████  █████████████████████ ████ █████ █████ ████ ██████


    ]]
      -- dashboard.section.header.val = vim.split(logo, "\n")
      local logo = {
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠋⠀⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠈⠉⠉⠙⠛⠛⠻⢿⣿⡿⠟⠁⠀⣀⣴⣿⣿⣿⣿⣿⠟",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠛⣉⣡⠀⣠⣴⣶⣶⣦⠄⣀⡀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⡿⢃⣾",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⣾⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⣠⣾⡟⢡⣾⣿⣿⣿⡿⢋⣴⣿⡿⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⢡⣾⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠃⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⣼⣿⡟⣰⣿⣿⣿⣿⠏⣰⣿⣿⠟⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢚⣛⢿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⠸⣿⠟⢰⣿⣿⣿⣿⠃⣾⣿⣿⠏⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢋⣾",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠻⠻⠃⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⢉⣴⣿⣿⣿⣿⡇⠘⣿⣿⠋⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡘⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⣿⣿⣿⣿⠁⢀⣀⠀⢀⣾⣿⣿⣿⣿⣿⣿⠟⠉⠉⠉⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣤⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣌",
        "⣿⣿⣿⣿⣿⣿⡿⠁⣀⣤⡀⠀⠈⠻⢿⠀⣼⣿⣷⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⠟⠛⠙⠃⠀⣿⣿⣿⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⡿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠁⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿",
        "⣿⠟⠁⢀⣴⣶⣶⣾⣿⣿⣿⣿⣶⡐⢦⣄⠀⠀⠈⠛⢿⣿⣿⣿⣿⡀⠀⠀⠀⠀⢀⣼⡿⢛⣩⣴⣶⣶⣶⣶⣶⣶⣭⣙⠻⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿",
        "⠁⠀⣴⣿⣿⣿⣿⠿⠿⣿⣿⣿⣿⣿⣦⡙⠻⣶⣄⡀⠀⠈⠙⢿⣿⣷⣦⣤⣤⣴⣿⡏⣠⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣌⠻⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿",
        "⠀⢸⣿⣿⣿⠋⣠⠔⠀⠀⠻⣿⣿⣿⣿⢉⡳⢦⣉⠛⢷⣤⣀⠀⠈⠙⠿⣿⣿⣿⣿⢸⣿⡄⠻⣿⣿⠟⡈⣿⣿⣿⣿⣿⢉⣿⣧⢹⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿",
        "⠀⢸⣿⣿⡇⠠⡇⠀⠀⠀⠀⣿⣿⣿⣿⢸⣿⣷⣤⣙⠢⢌⡛⠷⣤⣄⠀⠈⠙⠿⣿⣿⣿⣿⣷⣦⣴⣾⣿⣤⣙⣛⣛⣥⣾⣿⣿⡌⣿⣿⣿⣷⣤⣀⣀⣀⣠⣴⣿⣿⣿⣿⣿⣿⣿",
        "⠀⢸⣿⣿⣷⡀⠡⠀⠀⠀⣰⣿⣿⣿⣿⢸⣿⣿⣿⣿⣿⣦⣌⡓⠤⣙⣿⣦⡄⠀⠈⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢡⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⠀⢸⣿⣿⣿⣿⣶⣤⣴⣾⣿⣿⣿⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣷⣾⣿⣿⣷⠀⣶⡄⠀⠈⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢃⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⠀⢸⣿⣿⣿⣿⣿⠟⠻⣿⣿⡏⣉⣭⣭⡘⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⣿⡇⢸⡇⢠⡀⠈⠙⠋⠉⠉⠉⠉⠛⠫⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⠀⢸⣿⣿⠛⣿⣿⣀⣀⣾⡿⢀⣿⣿⣿⢻⣷⣦⢈⡙⠻⢿⣿⣿⣿⣿⣿⣿⣿⠀⣿⡇⢸⡇⢸⣿⠀⣦⠀⠀⠶⣶⣦⣀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⠀⢸⣿⣿⣦⣈⡛⠿⠟⣋⣤⣾⣿⣿⣿⣸⣿⣿⢸⡇⢰⡆⢈⡙⠻⢿⣿⣿⣿⠀⢿⡇⢸⡇⢸⣿⢠⣿⡇⣿⡆⢈⡙⠻⠧⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⠀⠀⣝⠛⢿⣿⣿⣿⣿⣿⣿⠟⣁⠀⠀⢈⠛⠿⢸⣇⢸⡇⢸⡇⣶⣦⣌⡙⠻⢄⡀⠁⠘⠇⠘⣿⢸⣿⡇⣿⡇⢸⡛⠷⣦⣄⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      }

      dashboard.section.header.val = logo
    -- stylua: ignore
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file",       LazyVim.pick()),
      dashboard.button("n", " " .. " New file",        [[<cmd> ene <BAR> startinsert <cr>]]),
      dashboard.button("r", " " .. " Recent files",    LazyVim.pick("oldfiles")),
      dashboard.button("g", " " .. " Find text",       LazyVim.pick("live_grep")),
      dashboard.button("c", " " .. " Config",          LazyVim.pick.config_files()),
      dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
      dashboard.button("x", " " .. " Lazy Extras",     "<cmd> LazyExtras <cr>"),
      dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <cr>"),
      dashboard.button("q", " " .. " Quit",            "<cmd> qa <cr>"),
    }

      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end

      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"

      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          once = true,
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {

        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
}
