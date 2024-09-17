return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require('nvim-treesitter.configs').setup({
      -- A list of parser names, or "all" (the listed parsers MUST always be installed)
      ensure_installed = "all",

      auto_install = true,

      indent = {
        enable = true
      },

      highlight = {
        enable = true
      },
    })
  end,
}
