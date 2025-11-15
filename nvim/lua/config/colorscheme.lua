return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        -- Try to load our custom theme first
        local ok, _ = pcall(require, 'colors')
        if ok then
          require('theme.apply').apply_theme()
        else
          -- Fallback to default theme if colors file doesn't exist yet
          vim.cmd.colorscheme("tokyonight")
        end
      end,
    },
  },
}
