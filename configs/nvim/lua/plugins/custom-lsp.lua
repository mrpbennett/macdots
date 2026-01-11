return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              -- BETTER K8s --
              schemas = {
                kubernetes = "**/*.yaml",
              },
            },
          },
        },
      },
    },
  },
}
