-- --------------------------------------------------
-- Palette Variants
-- --------------------------------------------------
local M = {}

M.variants = {
  lilac = {
    ansi = {
      "#232323", "#fba6df", "#9bcafb", "#fcb2c7",
      "#94b3fb", "#c995f9", "#9c98f8", "#b4b3c0",
      "#84838c", "#fbbbe6", "#bbdafb", "#faabc3",
      "#a5befa", "#c995f9", "#9c98f8", "#e0deee",
    },
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
