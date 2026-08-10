-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- For wrapping texts and diagnostics outside viewport
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showtabline = 0
vim.o.updatetime = 300

vim.diagnostic.config({
  underline = true,
  signs = true,
  virtual_text = false,
  update_in_insert = false,
  severity_sort = false,
})
