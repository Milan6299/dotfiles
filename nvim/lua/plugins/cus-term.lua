local job_id = nil
local terminal_buf = nil
local HEIGHT = 7

local function term_notify(msg, level, opts)
  opts = opts or {}
  vim.notify(msg or "No message found!", level or vim.log.levels.INFO, {
    title = opts.title or "Terminal",
    hide_from_history = opts.hide_from_history ~= false,
  })
end

local function floatingterm(opts)
  opts = opts or {}
  if not opts.terminal_buf then
    term_notify("No existing buffer found", "warn")
    return
  end
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

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
    border = "rounded",
  }

  -- vim.cmd.term()
  vim.api.nvim_open_win(opts.terminal_buf, true, win_config)
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
  -- delete the empty buffer with a paranoid sanity check
  if empty_buf ~= opts.terminal_buf then
    vim.api.nvim_buf_delete(empty_buf, {
      force = true,
    })
  end
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, opts.height or HEIGHT)
end

local function create_terminal(opts)
  opts = opts or {}

  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, opts.height or HEIGHT)

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
      float = opts.float,
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
  custom_terminal({ float = true })

  vim.fn.chansend(job_id, "uv run " .. vim.fn.shellescape(file) .. "\n")
end, { desc = "uv run file" })

vim.keymap.set("n", "<leader>rp", function()
  local file = vim.fn.expand("%:p")

  if not job_id then
    term_notify("Create a terminal first!", "warn")
    return
  end
  custom_terminal({ float = true })

  vim.fn.chansend(job_id, "python " .. vim.fn.shellescape(file) .. "\n")
end, { desc = "Run Python file" })

return {}
