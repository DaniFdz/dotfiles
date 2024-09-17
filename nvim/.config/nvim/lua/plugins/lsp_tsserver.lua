return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        settings = {
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