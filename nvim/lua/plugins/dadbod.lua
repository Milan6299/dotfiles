return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    -- { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'pgsql' }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    -- vim.g.db_ui_disable_progress_bar = 1
    vim.g.db_ui_disable_info_notifications = 1
  end,
}
