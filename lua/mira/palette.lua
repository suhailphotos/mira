-- --------------------------------------------------
-- Palette Variants
-- --------------------------------------------------
local M = {}

M.variants = {
  lilac = {
    -- bg = "#", bg_alt = "#", fg = "#",
    -- subtle = "#", muted = "#", comment = "#",
    -- red = "#", orange = "#", yellow = "#", green = "#",
    -- cyan = "#", blue = "#", magenta = "#",
    -- sel = "#", line = "#", float = "#", border = "#",
    -- git_add = "#", git_change = "#", git_del = "#",
    -- err = "#", warn = "#", info = "#", hint = "#", ok = "#",
  },
}

function M.get(name)
  name = name or "lilac"
  return vim.tbl_deep_extend("force", {}, M.variants[name] or {})
end

return M
