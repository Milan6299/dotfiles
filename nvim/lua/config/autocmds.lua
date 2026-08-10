-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
--
-- diagnostics on cursor hold
-- vim.api.nvim_create_autocmd("CursorHold", {
--   callback = function()
--     vim.diagnostic.open_float(nil, {
--       show_header = true,
--       focusable = false,
--       scope = "line",
--       border = "rounded",
--       source = "if_many",
--     })
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "markdown", "text", "gitcommit" },
--   callback = function()
--     vim.opt_local.wrap = true
--     vim.opt_local.linebreak = true
--   end,
-- })

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(args)
    vim.bo[args.buf].buflisted = false
    vim.bo[args.buf].swapfile = false
    -- vim.bo[args.buf].bufhidden = "hide"
  end,
})
