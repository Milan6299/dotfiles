local job_id = nil
local terminal_buf = nil
local height = 7
local function term_notify(msg, level, opts)
  opts = opts or {}
  vim.notify(msg or "No message found!", level or vim.log.levels.INFO, {
    title = opts.title or "Terminal",
    hide_from_history = opts.hide_from_history ~= false,
  })
end

local function open_terminal(opts)
  opts = opts or {}
  if not opts.terminal_buf then
    term_notify("No buffer found!", "warn")
    return
  end
  vim.cmd.vnew()
  -- when vnew starts it creates a empty buffer, store that buffer id
  local empty_buf = vim.api.nvim_get_current_buf()
  -- attach window to terminals buffer id
  vim.api.nvim_win_set_buf(0, opts.terminal_buf)
  -- delete the empty buffer with a paranoid sanity check
  if empty_buf ~= opts.terminal_buf then
    vim.api.nvim_buf_delete(empty_buf, {
      force = true,
    })
  end
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, opts.height or height)
end

local function create_terminal(opts)
  opts = opts or {}

  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, opts.height or height)

  return vim.api.nvim_get_current_buf()
end

local function custom_terminal(opts)
  opts = opts or {}

  if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
    -- if terminal window is open do not redraw
    if vim.fn.bufwinid(terminal_buf) ~= -1 then
      -- term_notify("Window visible!", "warn")
      return
    end
    open_terminal({
      terminal_buf = terminal_buf,
      height = opts.height,
    })
    return
  end

  term_notify("Launching Terminal!")
  terminal_buf = create_terminal({
    height = opts.height,
  })

  -- Store the terminals channel id
  job_id = vim.bo.channel

  vim.keymap.set("n", "q", "<cmd>hide<CR>", {
    buffer = terminal_buf,
    silent = true,
  })
end

vim.keymap.set("n", "<leader>tt", function()
  custom_terminal()
end, { desc = "Open custom Terminal" })

-- terminal mode to normal mode
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

vim.keymap.set("n", "<leader>pr", function()
  local file = vim.fn.expand("%:p")

  if not job_id then
    term_notify("Create a terminal first!", "warn")
    return
  end
  custom_terminal({ height = 10 })
  -- term_notify(file)

  vim.fn.chansend(job_id, "uv run " .. vim.fn.shellescape(file) .. "\n")
end, { desc = "uv run file" })

vim.keymap.set("n", "<leader>rp", function()
  local file = vim.fn.expand("%:p")

  if not job_id then
    term_notify("Create a terminal first!", "warn")
    return
  end
  custom_terminal()
  -- term_notify(file)

  vim.fn.chansend(job_id, "python " .. vim.fn.shellescape(file) .. "\n")
end, { desc = "Run Python file" })

return {}
