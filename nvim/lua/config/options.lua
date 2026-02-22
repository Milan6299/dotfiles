-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- For wrapping texts and diagnostics outside viewport
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showtabline = 0
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})
vim.diagnostic.config({
  underline = true,
  signs = true,
  virtual_text = false,
  update_in_insert = false, -- default to false
  severity_sort = false, -- default to false
})
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      show_header = true,
      focusable = false, -- don’t steal keyboard focus
      scope = "line", -- only show diagnostics for the current line
      border = "rounded", -- optional
      source = "if_many", -- show source if multiple
    })
  end,
})
vim.o.updatetime = 300 -- milliseconds
