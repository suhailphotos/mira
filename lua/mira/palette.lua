-- Start with an empty scaffold for 'lilac'. Add real hexes later.
local M = {}

M.variants = {
  lilac = {
    -- Fill these in as you iterate:
    -- bg = "#", fg = "#",
    -- muted = "#", subtle = "#",
    -- red = "#", orange = "#", yellow = "#", green = "#",
    -- cyan = "#", blue = "#", magenta = "#",
    -- sel = "#", line = "#", float = "#", border = "#", comment = "#",
    -- git_add = "#", git_change = "#", git_del = "#",
    -- err = "#", warn = "#", info = "#", hint = "#", ok = "#",
  },
}

function M.get(name)
  name = name or "lilac"
  return vim.tbl_deep_extend("force", {}, M.variants[name] or {})
end

return M
