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
        postgres_lsp = {
          cmd = { "postgres-language-server", "lsp-proxy" },
        },
      },
      diagnostics = {
        virtual_text = false,
      },
    },
  },
}
