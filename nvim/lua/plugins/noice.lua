return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    -- 🔑 REQUIRED: actually let Noice render LSP markdown
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },

    -- 🔑 Markdown wrapping
    markdown = {
      break_line = true,
    },

    -- 🔑 Wrap the hover/documentation view
    views = {
      hover = {
        win_options = {
          wrap = true,
          linebreak = true,
        },
      },
    },

    notify = {
      enabled = true,
    },
  },
}
