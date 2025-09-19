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

local ANSI_ONLY = (vim.g.mira_ansi_only == true)

-- ANSI helpers (index 0..15)
local function afg(_, i)
  if ANSI_ONLY then return { ctermfg = i } end
  return nil
end
local function abg(_, i)
  if ANSI_ONLY then return { ctermbg = i } end
  return nil
end
local function afgbg(_, fi, bi)
  if ANSI_ONLY then return { ctermfg = fi, ctermbg = bi } end
  return nil
end

function M.apply(P)
  -- In ansi-only mode we don't care about P at all.
  -- We just map indices → UI/syntax via cterm.

  -- --------------------------------------------------
  -- Core UI (ANSI indices)
  -- --------------------------------------------------
  -- Leave Normal/NormalNC alone to honor terminal bg/fg.
  hi("StatusLine",   afgbg(P, 4, 0))   -- bright white on ANSI black
  hi("StatusLineNC", afgbg(P, 8,  0))   -- dim gray on ANSI black
  hi("WinSeparator", afg(P, 8))
  hi("LineNr",       afg(P, 8))
  hi("CursorLine",   abg(P, 8))
  hi("CursorLineNr", afg(P, 15))
  hi("Visual",       abg(P, 8))
  hi("EndOfBuffer",  afg(P, 8))

  hi("Pmenu",        afgbg(P, 15, 0))
  hi("PmenuSel",     afgbg(P, 0,  15))
  hi("NormalFloat",  afgbg(P, 15, 0))
  hi("FloatBorder",  afgbg(P, 8,  0))

  -- --------------------------------------------------
  -- Syntax (ANSI indices)
  -- --------------------------------------------------
  hi("Comment",    afg(P, 8))
  hi("String",     afg(P, 2))   -- green
  hi("Character",  afg(P, 2))
  hi("Number",     afg(P, 3))   -- yellow
  hi("Float",      afg(P, 3))
  hi("Boolean",    afg(P, 3))
  hi("Identifier", afg(P, 15))  -- bright fg
  hi("Function",   afg(P, 4))   -- blue
  hi("Keyword",    afg(P, 5))   -- magenta
  hi("Statement",  afg(P, 5))
  hi("Type",       afg(P, 11))  -- bright yellow
  hi("Operator",   afg(P, 6))   -- cyan
  hi("Constant",   afg(P, 12))  -- bright blue

  -- Diagnostics (underline still works; undercurl color is terminal-chosen)
  hi("DiagnosticError", afg(P, 1))
  hi("DiagnosticWarn",  afg(P, 3))
  hi("DiagnosticInfo",  afg(P, 4))
  hi("DiagnosticHint",  afg(P, 6))
  hi("DiagnosticOk",    afg(P, 2))

  -- Treesitter links (names only; colors resolved by the linked groups)
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
