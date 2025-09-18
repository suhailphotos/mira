-- --------------------------------------------------
-- Highlight Mapping
-- --------------------------------------------------
local M = {}

local function hi(group, spec)
  if type(spec) ~= "table" then return end
  if not (spec.fg or spec.bg or spec.bold or spec.italic or spec.underline
          or spec.undercurl or spec.link or spec.sp) then
    return
  end
  vim.api.nvim_set_hl(0, group, spec)
end

-- ANSI helpers (index 0..15)
local function ansi_hex(P, i)
  -- Lua tables are 1-indexed; ANSI is 0..15 → shift by +1
  return (P.ansi and P.ansi[i + 1]) or nil
end
local function afg(P, i)
  local x = ansi_hex(P, i)
  return x and { fg = x, ctermfg = i } or nil
end
local function abg(P, i)
  local x = ansi_hex(P, i)
  return x and { bg = x, ctermbg = i } or nil
end
local function afgbg(P, fi, bi)
  local s, f, b = {}, ansi_hex(P, fi), ansi_hex(P, bi)
  if f then s.fg = f; s.ctermfg = fi end
  if b then s.bg = b; s.ctermbg = bi end
  return next(s) and s or nil
end

function M.apply(P)
  if type(P) ~= "table" or next(P) == nil then return end

  -- --------------------------------------------------
  -- Core UI (ANSI-first)
  -- --------------------------------------------------
  -- Leave Normal/NormalNC alone to honor the terminal background/foreground.
  -- Give a clear, terminal-driven statusline baseline:
  hi("StatusLine",   afgbg(P, 15, 0))   -- bright white on black
  hi("StatusLineNC", afgbg(P, 8,  0))   -- dim gray on black
  hi("WinSeparator", afg(P, 8))
  hi("LineNr",       afg(P, 8))
  hi("CursorLine",   abg(P, 8))
  hi("CursorLineNr", afg(P, 15))
  hi("Visual",       abg(P, 8))
  hi("EndOfBuffer",  afg(P, 8))

  -- Popup/menu clarity
  hi("Pmenu",        afgbg(P, 15, 0))
  hi("PmenuSel",     afgbg(P, 0,  15))

  -- Float borders use a neutral
  hi("NormalFloat",  afgbg(P, 15, 0))
  hi("FloatBorder",  afgbg(P, 8,  0))

  -- --------------------------------------------------
  -- Syntax (ANSI-first)
  -- --------------------------------------------------
  hi("Comment",    afg(P, 8))
  hi("String",     afg(P, 2))   -- green
  hi("Character",  afg(P, 2))
  hi("Number",     afg(P, 3))   -- yellow
  hi("Float",      afg(P, 3))
  hi("Boolean",    afg(P, 3))
  hi("Identifier", afg(P, 15))  -- default bright fg
  hi("Function",   afg(P, 4))   -- blue
  hi("Keyword",    afg(P, 5))   -- magenta
  hi("Statement",  afg(P, 5))
  hi("Type",       afg(P, 11))  -- bright yellow
  hi("Operator",   afg(P, 6))   -- cyan
  hi("Constant",   afg(P, 12))  -- bright blue

  -- Diagnostics
  hi("DiagnosticError", afg(P, 1))
  hi("DiagnosticWarn",  afg(P, 3))
  hi("DiagnosticInfo",  afg(P, 4))
  hi("DiagnosticHint",  afg(P, 6))
  hi("DiagnosticOk",    afg(P, 2))
  hi("DiagnosticUnderlineError", { undercurl = true, sp = ansi_hex(P, 1) })
  hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = ansi_hex(P, 3) })
  hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = ansi_hex(P, 4) })
  hi("DiagnosticUnderlineHint",  { undercurl = true, sp = ansi_hex(P, 6) })

  -- Treesitter → link to the Vim groups above
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
