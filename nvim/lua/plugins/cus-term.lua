local job_id = nil
local terminal_buf = nil
local config = {
  height = 7,
}

local function term_notify(msg, level, opts)
  opts = opts or {}
  vim.notify(msg or "No message found!", level or vim.log.levels.INFO, {
    title = opts.title or "Terminal",
    hide_from_history = opts.hide_from_history ~= false,
  })
end

local function terminal_window_defaults(win)
  vim.api.nvim_set_option_value("number", false, { win = win })
  vim.api.nvim_set_option_value("relativenumber", false, { win = win })
  vim.api.nvim_set_option_value("signcolumn", "no", { win = win })
end

local function floatingterm(opts)
  opts = opts or {}

  local width = opts.width or math.floor(vim.o.columns * 0.9)
  local height = opts.height or math.floor(vim.o.lines * 0.9)

  local posx = math.floor((vim.o.columns - width) / 2)
  local posy = math.floor((vim.o.lines - height) / 2)
  -- print(posx, posy)

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = posx,
    row = posy,
    style = "minimal",
    border = "single",
  }

  local buf = opts.terminal_buf
  if buf then
    local win = vim.api.nvim_open_win(buf, true, win_config)
    terminal_window_defaults(win)
    -- term_notify("using existing")
    return
  end

  buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, win_config)
  terminal_window_defaults(win)
  vim.cmd.term()

  return buf
end

local function open_terminal(opts)
  opts = opts or {}
  if not opts.terminal_buf then
    term_notify("No buffer found!", "warn")
    return
  end
  if opts.float then
    floatingterm({ terminal_buf = opts.terminal_buf })
    return
  end

  vim.cmd.vnew()
  -- when vnew starts it creates a empty buffer, store that buffer id
  local empty_buf = vim.api.nvim_get_current_buf()
  -- attach window to terminals buffer id
  vim.api.nvim_win_set_buf(0, opts.terminal_buf)
  terminal_window_defaults(vim.api.nvim_get_current_win())
  -- delete the empty buffer with a paranoid sanity check
  -- term_notify("empty " .. empty_buf .. " terminal " .. opts.terminal_buf)
  if empty_buf ~= opts.terminal_buf then
    vim.api.nvim_buf_delete(empty_buf, {
      force = true,
    })
  end
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, opts.height or config.height)
end

local function create_terminal(opts)
  opts = opts or {}

  if opts.float then
    return floatingterm({ terminal_buf = terminal_buf })
  end

  vim.cmd.vnew()
  vim.cmd.term()

  -- grab current window and set the terminal defaults
  local win = vim.api.nvim_get_current_win()
  terminal_window_defaults(win)

  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(win, opts.height or config.height)

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
    -- term_notify("opening existing " .. terminal_buf)
    open_terminal({
      float = opts.float,
      terminal_buf = terminal_buf,
      height = opts.height,
    })
    return
  end

  term_notify("Launching Terminal!")
  terminal_buf = create_terminal({
    height = opts.height,
    float = opts.float,
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

vim.keymap.set("n", "<leader>tf", function()
  custom_terminal({ float = true })
end, { desc = "Open custom Terminal" })

-- terminal mode to normal mode
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

vim.keymap.set("n", "<leader>pr", function()
  local file = vim.fn.expand("%:p")

  custom_terminal({ float = true })
  if not job_id then
    term_notify("No job id found!", "warn")
    return
  end

  vim.fn.chansend(job_id, "uv run " .. vim.fn.shellescape(file) .. "\n")
end, { desc = "uv run file" })

vim.keymap.set("n", "<leader>rp", function()
  local file = vim.fn.expand("%:p")

  custom_terminal({ float = true })

  if not job_id then
    term_notify("No job id found!", "warn")
    return
  end
  vim.fn.chansend(job_id, "python " .. vim.fn.shellescape(file) .. "\n")
end, { desc = "Run Python file" })

return {}
