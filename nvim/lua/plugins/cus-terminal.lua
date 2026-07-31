local job_id = nil
local terminal_buf = nil

local function create_terminal(opts)
  opts = opts or {}

  local height = opts.height or 5
  local buf = opts.terminal_buf

  vim.cmd.vnew()

  if buf and vim.api.nvim_buf_is_valid(buf) then
    -- Reuse an existing terminal buffer.
    vim.api.nvim_win_set_buf(0, buf)
  else
    -- Create a new terminal in this window.
    vim.cmd.term()
    buf = vim.api.nvim_get_current_buf()
  end

  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, height or 5)

  return buf
end

local function floating_terminal(opts)
  opts = opts or {}

  if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
    Snacks.notifier.notify("Found buffer id " .. tostring(terminal_buf))
    create_terminal({
      terminal_buf = terminal_buf,
      height = opts.height,
    })
    return
  end

  Snacks.notifier.notify("Creating buffer!")
  terminal_buf = create_terminal({
    height = opts.height,
  })

  job_id = vim.bo.channel

  vim.keymap.set("n", "q", "<cmd>hide<CR>", {
    buffer = terminal_buf,
    silent = true,
  })
end

vim.keymap.set("n", "<leader>tt", function()
  floating_terminal({ height = 5 })
end, { desc = "Open custom Terminal" })

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

vim.keymap.set("n", "<leader>rp", function()
  local file = vim.fn.expand("%")

  floating_terminal()
  -- Snacks.notifier.notify(file)

  vim.fn.chansend(job_id, "python " .. vim.fn.shellescape(file) .. "\n")
end, { desc = "Run Python file" })

return {}
