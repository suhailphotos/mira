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

local function fg(P, k) return P[k] and { fg = P[k] } or nil end
local function bg(P, k) return P[k] and { bg = P[k] } or nil end
local function fgbg(P, fk, bk)
  local s = {}
  if P[fk] then s.fg = P[fk] end
  if P[bk] then s.bg = P[bk] end
  return next(s) and s or nil
end

function M.apply(P)
  if type(P) ~= "table" or next(P) == nil then return end

  -- Core UI
  hi("Normal",       fgbg(P, "fg", "bg"))
  hi("NormalNC",     fgbg(P, "fg", "bg"))
  hi("CursorLine",   bg(P,  "line"))
  hi("CursorColumn", bg(P,  "line"))
  hi("Visual",       bg(P,  "sel"))
  hi("WinSeparator", fg(P,  "border"))
  hi("StatusLine",   fgbg(P, "subtle", "bg_alt"))
  hi("StatusLineNC", fgbg(P, "muted",  "bg_alt"))
  hi("Pmenu",        fgbg(P, "fg", "float"))
  hi("PmenuSel",     fgbg(P, "fg", "sel"))
  hi("NormalFloat",  fgbg(P, "fg", "float"))
  hi("FloatBorder",  fgbg(P, "border", "float"))
  hi("LineNr",       fg(P,  "muted"))
  hi("CursorLineNr", fg(P,  "fg"))
  hi("EndOfBuffer",  fg(P,  "border"))

  -- Syntax
  hi("Comment",    fg(P, "comment"))
  hi("String",     fg(P, "green"))
  hi("Character",  fg(P, "green"))
  hi("Number",     fg(P, "orange"))
  hi("Float",      fg(P, "orange"))
  hi("Boolean",    fg(P, "orange"))
  hi("Identifier", fg(P, "fg"))
  hi("Function",   fg(P, "blue"))
  hi("Keyword",    fg(P, "magenta"))
  hi("Statement",  fg(P, "magenta"))
  hi("Type",       fg(P, "yellow"))
  hi("Operator",   fg(P, "cyan"))
  hi("Constant",   fg(P, "cyan"))

  -- Diagnostics
  hi("DiagnosticError", fg(P, "err"))
  hi("DiagnosticWarn",  fg(P, "warn"))
  hi("DiagnosticInfo",  fg(P, "info"))
  hi("DiagnosticHint",  fg(P, "hint"))
  hi("DiagnosticOk",    fg(P, "ok"))
  hi("DiagnosticUnderlineError", { undercurl = true, sp = P.err })
  hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = P.warn })
  hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = P.info })
  hi("DiagnosticUnderlineHint",  { undercurl = true, sp = P.hint })

  -- Treesitter (links)
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
