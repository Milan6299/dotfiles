require("config.lazy")

vim.opt.termguicolors = true

-- Load and apply theme
local colors = require("colors")
local theme = require("theme.apply")

-- Apply theme on startup
vim.schedule(function()
  theme.apply_theme()
end)

-- Reload when file is written internally
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*/nvim/lua/colors.lua",
  callback = function()
    package.loaded["colors"] = nil
    require("apply").reload_colors()
  end,
})

-- Reload when file is changed externally
vim.api.nvim_create_autocmd("FileChangedShell", {
  pattern = "*/nvim/lua/colors.lua",
  callback = function()
    package.loaded["colors"] = nil
    require("apply").reload_colors()
    vim.notify("Theme reloaded!", vim.log.levels.INFO)
    return true -- Accept the change
  end,
})
