local colors = require("colors")

local function apply_theme()
  -- Clear existing highlights
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.g.colors_name = "my_theme"

  -- ============ BASIC UI ELEMENTS ============
  -- Editor
  vim.api.nvim_set_hl(0, "Normal", { fg = colors.fg, bg = colors.bg })
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = colors.fg, bg = colors.bg })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.border, bg = colors.bg })
  vim.api.nvim_set_hl(0, "NormalNC", { fg = colors.fg_dim, bg = colors.bg })
  vim.api.nvim_set_hl(0, "FloatTitle", { fg = colors.fg, bg = colors.bg })

  -- Line numbers
  vim.api.nvim_set_hl(0, "LineNr", { fg = colors.gray5, bg = colors.bg })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.bg_alt })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.accent, bg = colors.bg_alt, bold = true })
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = colors.bg_alt })

  -- Windows and splits
  vim.api.nvim_set_hl(0, "VertSplit", { fg = colors.border, bg = colors.bg })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.border, bg = colors.bg })
  vim.api.nvim_set_hl(0, "WinBar", { fg = colors.fg, bg = colors.bg_alt })
  vim.api.nvim_set_hl(0, "WinBarNC", { fg = colors.fg_dim, bg = colors.bg_alt })

  -- Statusline
  vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.fg, bg = colors.bg_alt })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.gray5, bg = colors.bg })
  vim.api.nvim_set_hl(0, "StatusLineTerm", { fg = colors.fg, bg = colors.bg_alt })
  vim.api.nvim_set_hl(0, "StatusLineTermNC", { fg = colors.gray5, bg = colors.bg })

  -- Cursor
  vim.api.nvim_set_hl(0, "Cursor", { fg = colors.bg, bg = colors.accent })
  vim.api.nvim_set_hl(0, "lCursor", { fg = colors.bg, bg = colors.accent })
  vim.api.nvim_set_hl(0, "CursorIM", { fg = colors.bg, bg = colors.accent_alt })
  vim.api.nvim_set_hl(0, "TermCursor", { fg = colors.bg, bg = colors.accent })

  -- Selection
  vim.api.nvim_set_hl(0, "Visual", { bg = colors.selection })
  vim.api.nvim_set_hl(0, "VisualNOS", { bg = colors.selection, blend = 50 })
  vim.api.nvim_set_hl(0, "MatchParen", { fg = colors.accent, bg = colors.bg_alt, bold = true })

  -- Search
  vim.api.nvim_set_hl(0, "Search", { fg = colors.bg, bg = colors.warning })
  vim.api.nvim_set_hl(0, "IncSearch", { fg = colors.bg, bg = colors.accent })
  vim.api.nvim_set_hl(0, "CurSearch", { fg = colors.bg, bg = colors.accent_alt })

  -- Messages and prompts
  vim.api.nvim_set_hl(0, "MsgArea", { fg = colors.fg, bg = colors.bg })
  vim.api.nvim_set_hl(0, "Title", { fg = colors.accent, bold = true })
  vim.api.nvim_set_hl(0, "Question", { fg = colors.info })
  vim.api.nvim_set_hl(0, "MoreMsg", { fg = colors.success })
  vim.api.nvim_set_hl(0, "ModeMsg", { fg = colors.accent, bold = true })
  vim.api.nvim_set_hl(0, "MsgSeparator", { fg = colors.border, bg = colors.bg })

  -- Popup menu
  vim.api.nvim_set_hl(0, "Pmenu", { fg = colors.fg, bg = colors.bg_alt })
  vim.api.nvim_set_hl(0, "PmenuSel", { fg = colors.bg, bg = colors.accent })
  vim.api.nvim_set_hl(0, "PmenuSbar", { bg = colors.gray3 })
  vim.api.nvim_set_hl(0, "PmenuThumb", { bg = colors.gray5 })
  vim.api.nvim_set_hl(0, "WildMenu", { fg = colors.bg, bg = colors.accent })

  -- Tabs
  vim.api.nvim_set_hl(0, "TabLine", { fg = colors.fg_dim, bg = colors.bg_alt })
  vim.api.nvim_set_hl(0, "TabLineSel", { fg = colors.accent, bg = colors.bg, bold = true })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = colors.bg_alt })

  -- Folding
  vim.api.nvim_set_hl(0, "Folded", { fg = colors.gray5, bg = colors.bg_alt, italic = true })
  vim.api.nvim_set_hl(0, "FoldColumn", { fg = colors.gray5, bg = colors.bg })

  -- Signs and gutters
  vim.api.nvim_set_hl(0, "SignColumn", { fg = colors.gray5, bg = colors.bg })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = colors.bg_alt })

  vim.api.nvim_set_hl(0, "Directory", { fg = colors.fg })

  -- ============ SYNTAX HIGHLIGHTING ============
  -- Comments
  vim.api.nvim_set_hl(0, "Comment", { fg = colors.gray7, italic = true })
  vim.api.nvim_set_hl(0, "SpecialComment", { fg = colors.gray7, italic = true, bold = true })

  -- Constants
  vim.api.nvim_set_hl(0, "Constant", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "String", { fg = colors.success })
  vim.api.nvim_set_hl(0, "Character", { fg = colors.success })
  vim.api.nvim_set_hl(0, "Number", { fg = colors.info })
  vim.api.nvim_set_hl(0, "Boolean", { fg = colors.error })
  vim.api.nvim_set_hl(0, "Float", { fg = colors.info })

  -- Identifiers
  vim.api.nvim_set_hl(0, "Identifier", { fg = colors.accent_alt })
  vim.api.nvim_set_hl(0, "Function", { fg = colors.accent })

  -- Statements
  vim.api.nvim_set_hl(0, "Statement", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "Conditional", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "Repeat", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "Label", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "Operator", { fg = colors.fg_dim })
  vim.api.nvim_set_hl(0, "Keyword", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "Exception", { fg = colors.error })

  -- Preprocessor
  vim.api.nvim_set_hl(0, "PreProc", { fg = colors.info })
  vim.api.nvim_set_hl(0, "Include", { fg = colors.info })
  vim.api.nvim_set_hl(0, "Define", { fg = colors.info })
  vim.api.nvim_set_hl(0, "Macro", { fg = colors.info })
  vim.api.nvim_set_hl(0, "PreCondit", { fg = colors.info })

  -- Types
  vim.api.nvim_set_hl(0, "Type", { fg = colors.info })
  vim.api.nvim_set_hl(0, "StorageClass", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "Structure", { fg = colors.info })
  vim.api.nvim_set_hl(0, "Typedef", { fg = colors.info })

  -- Special
  vim.api.nvim_set_hl(0, "Special", { fg = colors.accent_alt })
  vim.api.nvim_set_hl(0, "SpecialChar", { fg = colors.accent_alt })
  vim.api.nvim_set_hl(0, "Tag", { fg = colors.accent_alt })
  vim.api.nvim_set_hl(0, "Delimiter", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "SpecialComment", { fg = colors.gray7 })
  vim.api.nvim_set_hl(0, "Debug", { fg = colors.error })

  -- ============ TREESITTER ============
  vim.api.nvim_set_hl(0, "@variable", { fg = colors.fg })
  vim.api.nvim_set_hl(0, "@variable.builtin", { fg = colors.fg })
  vim.api.nvim_set_hl(0, "@constant", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "@constant.builtin", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "@constant.macro", { fg = colors.info })
  vim.api.nvim_set_hl(0, "@string", { fg = colors.success })
  vim.api.nvim_set_hl(0, "@string.regex", { fg = colors.accent_alt })
  vim.api.nvim_set_hl(0, "@string.escape", { fg = colors.accent_alt })
  vim.api.nvim_set_hl(0, "@character", { fg = colors.success })
  vim.api.nvim_set_hl(0, "@number", { fg = colors.error })
  vim.api.nvim_set_hl(0, "@boolean", { fg = colors.error })
  vim.api.nvim_set_hl(0, "@float", { fg = colors.error })
  vim.api.nvim_set_hl(0, "@function", { fg = colors.accent })
  vim.api.nvim_set_hl(0, "@function.builtin", { fg = colors.accent })
  vim.api.nvim_set_hl(0, "@function.macro", { fg = colors.accent })
  vim.api.nvim_set_hl(0, "@method", { fg = colors.accent })
  vim.api.nvim_set_hl(0, "@constructor", { fg = colors.accent })
  vim.api.nvim_set_hl(0, "@parameter", { fg = colors.info })
  vim.api.nvim_set_hl(0, "@keyword", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "@keyword.function", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "@keyword.operator", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "@conditional", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "@repeat", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "@label", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "@operator", { fg = colors.fg_dim })
  vim.api.nvim_set_hl(0, "@exception", { fg = colors.error })
  vim.api.nvim_set_hl(0, "@type", { fg = colors.info })
  vim.api.nvim_set_hl(0, "@type.builtin", { fg = colors.info })
  vim.api.nvim_set_hl(0, "@structure", { fg = colors.info })
  vim.api.nvim_set_hl(0, "@include", { fg = colors.info })
  vim.api.nvim_set_hl(0, "@annotation", { fg = colors.info }) -- Blue for decorators
  vim.api.nvim_set_hl(0, "@attribute", { fg = colors.warning }) -- Yellow for HTML attributes
  vim.api.nvim_set_hl(0, "@property", { fg = colors.fg_dim }) -- Purple for object properties
  vim.api.nvim_set_hl(0, "@field", { fg = colors.success }) -- Green for struct fields
  vim.api.nvim_set_hl(0, "@namespace", { fg = colors.fg_dim })
  vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = colors.warning })

  -- ============ LSP ============
  vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.error })
  vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.warning })
  vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.info })
  vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.accent_alt })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = colors.error, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = colors.warning, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { sp = colors.info, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { sp = colors.accent_alt, undercurl = true })

  vim.api.nvim_set_hl(0, "LspReferenceText", { bg = colors.selection })
  vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = colors.selection })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = colors.selection })

  -- ============ LUALINE ============
  -- Configure Lualine if installed
  local lualine_ok, lualine = pcall(require, "lualine")
  if lualine_ok then
    lualine.setup({
      options = {
        theme = {
          normal = {
            a = { bg = colors.accent, fg = colors.bg, gui = "bold" },
            b = { bg = colors.bg_alt, fg = colors.fg },
            c = { bg = colors.bg, fg = colors.fg },
          },
          insert = {
            a = { bg = colors.success, fg = colors.bg, gui = "bold" },
          },
          visual = {
            a = { bg = colors.warning, fg = colors.bg, gui = "bold" },
          },
          replace = {
            a = { bg = colors.error, fg = colors.bg, gui = "bold" },
          },
          command = {
            a = { bg = colors.info, fg = colors.bg, gui = "bold" },
          },
          inactive = {
            a = { bg = colors.bg, fg = colors.gray5 },
            b = { bg = colors.bg, fg = colors.gray5 },
            c = { bg = colors.bg, fg = colors.gray5 },
          },
        },
      },
    })
  end

  -- ============ DIFF & GIT ============
  vim.api.nvim_set_hl(0, "DiffAdd", { fg = colors.success, bg = colors.bg_alt })
  vim.api.nvim_set_hl(0, "DiffChange", { fg = colors.warning, bg = colors.bg_alt })
  vim.api.nvim_set_hl(0, "DiffDelete", { fg = colors.error, bg = colors.bg_alt })
  vim.api.nvim_set_hl(0, "DiffText", { fg = colors.info, bg = colors.bg_alt })

  vim.api.nvim_set_hl(0, "gitcommitOverflow", { fg = colors.error })
  vim.api.nvim_set_hl(0, "gitcommitSummary", { fg = colors.success })

  --------- BLINK CMP --------------
  vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = colors.bg_alt })
  vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = colors.bg_alt })
  vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { bg = colors.bg_alt })

  vim.notify("Theme applied successfully!", vim.log.levels.INFO)
end

local function reload_colors()
  package.loaded["colors"] = nil
  apply_theme()
end

return { apply_theme = apply_theme, reload_colors = reload_colors }
