-- --------------------------------------------------
-- Palette Variants
-- --------------------------------------------------
local M = {}

M.variants = {
  lilac = {
    -- main tokens (you'll fill these later)
    -- bg = "#", bg_alt = "#", fg = "#", ... etc ...

    -- ANSI 16 (index 0..15)
    ansi = {
      "#232323", "#fba6df", "#9bcafb", "#fcb2c7",
      "#94b3fb", "#c995f9", "#9c98f8", "#b4b3c0",
      "#84838c", "#fbbbe6", "#bbdafb", "#faabc3",
      "#a5befa", "#c995f9", "#9c98f8", "#e0deee",
    },
  },
}

function M.get(name)
  name = name or "lilac"
  return vim.tbl_deep_extend("force", {}, M.variants[name] or {})
end

return M
