-- --------------------------------------------------
-- Highlight Mapping
-- --------------------------------------------------
local M = {}

local function hi(group, spec)
  if type(spec) ~= "table" then return end
  if not (spec.fg or spec.bg or spec.bold or spec.italic or spec.underline
          or spec.undercurl or spec.link or spec.sp or spec.ctermfg or spec.ctermbg) then
    return
  end
  vim.api.nvim_set_hl(0, group, spec)
end

-- ANSI helpers (index 0..15); resolved inside apply() via current mode
local function afg(_, i, ansi_only)
  if ansi_only then return { ctermfg = i } end
end
local function abg(_, i, ansi_only)
  if ansi_only then return { ctermbg = i } end
end
local function afgbg(_, fi, bi, ansi_only)
  if ansi_only then return { ctermfg = fi, ctermbg = bi } end
end

function M.apply(P)
  -- read the switch *now*, so toggling mid-session works
  local ANSI_ONLY = (vim.g.mira_ansi_only == true)

  -- --------------------------------------------------
  -- Intro / generic UI accents
  -- --------------------------------------------------
  hi("Title",       afg(P, 15, ANSI_ONLY))
  hi("Question",    afg(P, 12, ANSI_ONLY))
  hi("MoreMsg",     afg(P, 12, ANSI_ONLY))
  hi("NonText",     afg(P, 8,  ANSI_ONLY))
  hi("SpecialKey",  afg(P, 8,  ANSI_ONLY))

  -- help.vim groups
  hi("helpHeader",         afg(P, 15, ANSI_ONLY))
  hi("helpSectionDelim",   afg(P, 8,  ANSI_ONLY))
  hi("helpHyperTextJump",  afg(P, 12, ANSI_ONLY))
  hi("helpHyperTextEntry", afg(P, 12, ANSI_ONLY))
  hi("helpURL",            afg(P, 12, ANSI_ONLY))
  hi("helpNote",           afg(P, 3,  ANSI_ONLY))
  hi("helpWarning",        afg(P, 1,  ANSI_ONLY))
  hi("helpExample",        afg(P, 2,  ANSI_ONLY))
  hi("helpSpecial",        afg(P, 6,  ANSI_ONLY))
  hi("helpOption",         afg(P, 4,  ANSI_ONLY))
  hi("helpCommand",        afg(P, 5,  ANSI_ONLY))
  hi("helpBacktick",       afg(P, 8,  ANSI_ONLY))

  -- --------------------------------------------------
  -- Core UI (ANSI indices)
  -- --------------------------------------------------
  -- Leave Normal/NormalNC alone to honor terminal bg/fg.
  hi("StatusLine",   afgbg(P, 4,  0, ANSI_ONLY))  -- blue on ANSI black
  hi("StatusLineNC", afgbg(P, 8,  0, ANSI_ONLY))  -- dim gray on black
  hi("WinSeparator", afg(P, 8,  ANSI_ONLY))
  hi("LineNr",       afg(P, 8,  ANSI_ONLY))
  hi("CursorLine",   abg(P, 8,  ANSI_ONLY))
  hi("CursorLineNr", afg(P, 7, ANSI_ONLY))       -- <-- true “white” (use 7 for light gray)
  hi("Visual",       abg(P, 8,  ANSI_ONLY))
  hi("EndOfBuffer",  afg(P, 8,  ANSI_ONLY))

  hi("Pmenu",        afgbg(P, 15, 0,  ANSI_ONLY))
  hi("PmenuSel",     afgbg(P, 0,  15, ANSI_ONLY))
  hi("NormalFloat",  afgbg(P, 15, 0,  ANSI_ONLY))
  hi("FloatBorder",  afgbg(P, 8,  0,  ANSI_ONLY))

  -- --------------------------------------------------
  -- Syntax (ANSI indices)
  -- --------------------------------------------------
  hi("Comment",    afg(P, 8,  ANSI_ONLY))
  hi("String",     afg(P, 2,  ANSI_ONLY))
  hi("Character",  afg(P, 2,  ANSI_ONLY))
  hi("Number",     afg(P, 3,  ANSI_ONLY))
  hi("Float",      afg(P, 3,  ANSI_ONLY))
  hi("Boolean",    afg(P, 3,  ANSI_ONLY))
  hi("Identifier", afg(P, 15, ANSI_ONLY))
  hi("Function",   afg(P, 4,  ANSI_ONLY))
  hi("Keyword",    afg(P, 5,  ANSI_ONLY))
  hi("Statement",  afg(P, 5,  ANSI_ONLY))
  hi("Type",       afg(P, 11, ANSI_ONLY))
  hi("Operator",   afg(P, 6,  ANSI_ONLY))
  hi("Constant",   afg(P, 12, ANSI_ONLY))

  -- Diagnostics
  hi("DiagnosticError", afg(P, 1, ANSI_ONLY))
  hi("DiagnosticWarn",  afg(P, 3, ANSI_ONLY))
  hi("DiagnosticInfo",  afg(P, 4, ANSI_ONLY))
  hi("DiagnosticHint",  afg(P, 6, ANSI_ONLY))
  hi("DiagnosticOk",    afg(P, 2, ANSI_ONLY))

  -- Treesitter links
  vim.api.nvim_set_hl(0, "@comment",  { link = "Comment"  })
  vim.api.nvim_set_hl(0, "@string",   { link = "String"   })
  vim.api.nvim_set_hl(0, "@number",   { link = "Number"   })
  vim.api.nvim_set_hl(0, "@boolean",  { link = "Boolean"  })
  vim.api.nvim_set_hl(0, "@constant", { link = "Constant" })
  vim.api.nvim_set_hl(0, "@function", { link = "Function" })
  vim.api.nvim_set_hl(0, "@keyword",  { link = "Keyword"  })
  vim.api.nvim_set_hl(0, "@type",     { link = "Type"     })
  vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })
end

return M
