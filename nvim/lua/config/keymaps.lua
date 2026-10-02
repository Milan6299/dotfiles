-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- For cursor to not skip wrapped texts
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Center screen after performing scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "G", "<Cmd>normal! Gzz<CR>")

vim.keymap.set("n", "<leader>dd", function()
  vim.diagnostic.open_float()
end, { desc = "Diagnostics" })

-- vim.keymap.set("t","<Esc><Esc>", )
-- quarto
vim.keymap.set(
  "n",
  "<leader>bi",
  "o```{python}<CR><CR><CR><CR>```<Esc>kki",
  { silent = true, desc = "Insert Python Block" }
)
vim.keymap.set("n", "<leader>db", ":DBUI<CR>", { desc = "Open DBUI" })
