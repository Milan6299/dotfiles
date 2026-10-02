return {
  "Milan6299/kwik-term",

  opts = {
    height = 7,
    width = 0.9,
    height_ratio = 0.9,
    border = "single",
    start_in_insert = false,
  },

  keys = {
    {
      "<leader>tt",
      function()
        require("kwik-term").toggle({ float = true })
      end,
      mode = "n",
      desc = "KwikTerm Float",
    },
    {
      "<leader>tv",
      function()
        require("kwik-term").toggle()
      end,
      mode = "n",
      desc = "KwikTerm Split",
    },
    {
      "<leader>ru",
      function()
        require("kwik-term").run_current_file("uv run", { float = true })
      end,
      mode = "n",
      desc = "Run file uv",
    },
    {
      "<leader>rp",
      function()
        require("kwik-term").run_current_file("python", { float = true })
      end,
      mode = "n",
      desc = "Run file python",
    },
  },
}
