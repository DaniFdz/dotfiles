return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        root_dir = require("lspconfig").util.root_pattern(".git"),
        settings = {
          vtsls = {
            autoUseWorkspaceTsdk = true,
          },
          javascript = {
            format = {
              enable = false,
            },
          },
          typescript = {
            preferences = {
              importModuleSpecifier = "non-relative",
            },
            tsserver = {
              maxTsServerMemory = 16384,
              watchOptions = {
                excludeFiles = { ".pnp.cjs" },
                excludeDirectories = { "**/node_modules", "**/.yarn" },
              },
            },
            tsdk = ".yarn/sdks/typescript/lib",
            files = {
              maxMemoryForLargeFilesMB = 12288,
            },
            format = {
              enable = false,
            },
          },
        },
      },
    },
  },
}
