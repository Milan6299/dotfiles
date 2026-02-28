return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        biome = {},
      },
      diagnostics = {
        virtual_text = false,
      },
    },
  },
}
