print("BrowserSync config loaded")
local bs_job = nil

local function toggle_browsersync()
  if bs_job then
    vim.fn.jobstop(bs_job)
    print("BrowserSync stopped")
    bs_job = nil
  else
    bs_job = vim.fn.jobstart({
      "browser-sync",
      "start",
      "--server",
      "--files",
      "**/*",
    }, {
      cwd = vim.fn.getcwd(),
      detach = true,
    })
    print("BrowserSync started")
  end
end

vim.keymap.set("n", "<leader>fx", toggle_browsersync, {
  silent = true,
  desc = "Toggle BrowserSync",
})
