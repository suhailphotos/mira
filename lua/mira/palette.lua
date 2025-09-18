-- --------------------------------------------------
-- Palette Variants (terminal-first)
-- --------------------------------------------------
local M = {}

M.variants = {
  lilac = {
    -- No hardcoded `ansi` here.
    -- Mira will read from vim.g.terminal_ansi_colors at load time.
  },
}

local function read_terminal_ansi()
  local t = vim.g.terminal_ansi_colors
  if type(t) == "table" and #t >= 16 then
    local out = {}
    for i = 1, 16 do out[i] = t[i] end
    return out
  end
end

function M.get(name)
  name = name or "lilac"
  local P = vim.tbl_deep_extend("force", {}, M.variants[name] or {})
  P.ansi = P.ansi or read_terminal_ansi() or {}
  return P
end

return M
