return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        biome = {},
        ts_ls = {
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
      },
      diagnostics = {
        virtual_text = false,
      },
    },
  },
}
