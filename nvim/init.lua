require("config.lazy")
require("config.browser-sync")

vim.opt.termguicolors = true

-- Load and apply theme
local theme = require("theme.apply")

-- Apply theme on startup
theme.apply_theme()
