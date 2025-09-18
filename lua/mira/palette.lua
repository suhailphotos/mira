-- --------------------------------------------------
-- Palette Variants
-- --------------------------------------------------
local M = {}

M.variants = {
  lilac = {
    -- Optional: you may add token hexes later, but not required now.
    -- ansi = { ... }  -- if omitted, we’ll read from terminal
  },
}

local function read_terminal_ansi()
  local t = vim.g.terminal_ansi_colors
  if type(t) == "table" and #t >= 16 then
    local out = {}
    for i = 1, 16 do out[i] = t[i] end
    return out
  end
  return nil
end

function M.get(name)
  name = name or "lilac"
  local P = vim.tbl_deep_extend("force", {}, M.variants[name] or {})
  P.ansi = P.ansi or read_terminal_ansi() or {}
  return P
end

return M
