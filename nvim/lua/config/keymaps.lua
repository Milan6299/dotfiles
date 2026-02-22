-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set(
  "n",
  "<leader>bi",
  "o```{python}<CR><CR><CR><CR>```<Esc>kk",
  { silent = true, desc = "Insert Python Block" }
)

-- For cursor to not skip wrapped texts
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<leader>dd", function()
  vim.diagnostic.open_float()
end, { desc = "Diagnostics" })
