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
-- run current buffer - python
-- vim.keymap.set("n", "<leader>r", function()
--   local pane = vim.fn
--     .system({
--       "tmux",
--       "split-window",
--       "-fv",
--       -- "-P",
--       -- "-F",
--       "-l",
--       "7",
--       "-PF",
--       "#{pane_id}",
--     })
--     :gsub("%s+$", "")
--
--   vim.fn.system({
--     "tmux",
--     "send-keys",
--     "-t",
--     pane,
--     "bash -c python " .. vim.fn.expand("%:p"),
--     "Enter",
--   })
-- end, { desc = "Run Python in new tmux pane" })
--
-- dadbod + dbui
vim.keymap.set("n", "<leader>db", ":DBUI<CR>", { desc = "Open DBUI" })

-- vim.keymap.set("n", "<leader>rp", function()
--   Snacks.terminal('bash -c "python ' .. vim.fn.expand("%:p") .. '; exec bash"')
-- end, { desc = "Run Python file" })
--
-- map("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
-- map("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
-- map({"n","t"}, "<c-/>",function() Snacks.terminal.focus(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
-- map({"n","t"}, "<c-_>",function() Snacks.terminal.focus(nil, { cwd = LazyVim.root() }) end, { desc = "which_key_ignore" })
--
