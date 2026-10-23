local function get_db_url()
  vim.cmd("silent! Dotenv")

  local url = ""
  if vim.fn.exists("*DotenvGet") == 1 then
    url = vim.fn.DotenvGet("DB_URL")
    if url == "" then
      url = vim.fn.DotenvGet("DATABASE_URL")
    end
  end

  if url == "" then
    url = vim.env.DB_URL or vim.env.DATABASE_URL or ""
  end

  if url == "" then
    vim.notify("DB_URL or DATABASE_URL not found in .env or environment", vim.log.levels.ERROR)
    return nil
  end

  return url
end

local function load_dadbod()
  require("lazy").load({ plugins = { "vim-dadbod" } })
end

return {
  {
    "tpope/vim-dotenv",
    keys = {
      {
        "<leader>rd",
        function()
          load_dadbod()

          local url = get_db_url()
          if not url then
            return
          end

          vim.cmd("%DB " .. vim.fn.fnameescape(url))
        end,
        mode = "n",
        desc = "Run entire SQL buffer",
      },
      {
        "<leader>re",
        function()
          -- Read the active selection before changing modes.
          local mode = vim.fn.mode()
          if mode ~= "V" then
            vim.notify("Use line-wise Visual mode (V) to select SQL lines", vim.log.levels.WARN)
            return
          end

          local start_line = vim.fn.getpos("v")[2]
          local end_line = vim.fn.getpos(".")[2]
          local first = math.min(start_line, end_line)
          local last = math.max(start_line, end_line)

          load_dadbod()

          local url = get_db_url()
          if not url then
            return
          end

          vim.cmd(first .. "," .. last .. "DB " .. vim.fn.fnameescape(url))
        end,
        mode = "x",
        desc = "Run selected SQL lines",
      },
    },
  },
}
