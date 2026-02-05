return {
  "folke/snacks.nvim",

  opts = {
    picker = {
      sources = {
        explorer = {
          auto_close = true, -- must be true for floating mode
          layout = {
            { preview = true },
            layout = {
              box = "horizontal",
              width = 0.8,
              height = 0.8,
              {
                box = "vertical",
                border = "rounded",
                title = "{source} {live} {flags}",
                title_pos = "center",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              {
                win = "preview",
                border = "rounded",
                width = 0.6,
                title = "{preview}",
              },
            },
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>ff",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader><space>",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
  },
}
