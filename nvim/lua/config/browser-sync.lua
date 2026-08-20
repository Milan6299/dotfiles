local bs_job = nil

local function toggle_browsersync()
  if bs_job then
    vim.fn.jobstop(bs_job)
    bs_job = nil
    print("BrowserSync stopped")
    return
  end

  bs_job = vim.fn.jobstart({
    "browser-sync",
    "start",
    "--server",
    "--files",
    "**/*",
  }, {
    cwd = vim.fn.getcwd(),
  })

  if bs_job <= 0 then
    bs_job = nil
    print("Failed to start BrowserSync")
    return
  end

  print("BrowserSync started")
end

vim.keymap.set("n", "<leader>gx", toggle_browsersync, {
  silent = true,
  desc = "Toggle BrowserSync",
})
