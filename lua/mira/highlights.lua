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

-- token helpers (unchanged)
local function fg(P, k) return P[k] and { fg = P[k] } or nil end
local function bg(P, k) return P[k] and { bg = P[k] } or nil end
local function fgbg(P, fk, bk)
  local s = {}
  if P[fk] then s.fg = P[fk] end
  if P[bk] then s.bg = P[bk] end
  return next(s) and s or nil
end

-- NEW: ANSI helpers (use ANSI by index; 0..15)
local function ansi_hex(P, i)
  return (P.ansi and P.ansi[i + 1]) or nil   -- Lua is 1-indexed
end
local function afg(P, i)
  local x = ansi_hex(P, i)
  return x and { fg = x } or nil
end
local function abg(P, i)
  local x = ansi_hex(P, i)
  return x and { bg = x } or nil
end
local function afgbg(P, fi, bi)
  local s, f, b = {}, ansi_hex(P, fi), ansi_hex(P, bi)
  if f then s.fg = f end
  if b then s.bg = b end
  return next(s) and s or nil
end

function M.apply(P)
  if type(P) ~= "table" or next(P) == nil then return end

  ------------------------------------------------------------------
  -- Core UI (token-driven if tokens exist)
  ------------------------------------------------------------------
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

  ------------------------------------------------------------------
  -- ANSI-first fallbacks (kick in when tokens are empty)
  -- This gives you a visible bar even with an empty palette.
  ------------------------------------------------------------------
  if P.ansi and not (P.bg or P.fg or P.subtle or P.bg_alt) then
    -- Statusline = bg: ANSI 0 (your “black”), text: ANSI 7 (light) / NC uses ANSI 8 (dim)
    hi("StatusLine",   afgbg(P, 7, 0))   -- fg=ansi7, bg=ansi0
    hi("StatusLineNC", afgbg(P, 8, 0))   -- fg=ansi8, bg=ansi0

    -- A couple of gentle defaults so the UI isn’t *totally* bare
    hi("LineNr",       afg(P, 8))        -- dim gutter numbers
    hi("CursorLine",   abg(P, 8))        -- subtle line band
    hi("EndOfBuffer",  afg(P, 8))
  end

  ------------------------------------------------------------------
  -- Syntax (token-driven)
  ------------------------------------------------------------------
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

  -- Diagnostics (token-driven)
  hi("DiagnosticError", fg(P, "err"))
  hi("DiagnosticWarn",  fg(P, "warn"))
  hi("DiagnosticInfo",  fg(P, "info"))
  hi("DiagnosticHint",  fg(P, "hint"))
  hi("DiagnosticOk",    fg(P, "ok"))
  hi("DiagnosticUnderlineError", { undercurl = true, sp = P.err })
  hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = P.warn })
  hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = P.info })
  hi("DiagnosticUnderlineHint",  { undercurl = true, sp = P.hint })

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
