-- Public API scaffold for your theme.
local M = {}

-- future: M.setup({ default_variant = "lilac", transparent = false, ... })
M.opts = { default_variant = "lilac" }

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
end

-- Later you'll compute highlights from palette + opts.
-- For now, load() is a no-op so calling it won’t change visuals.
function M.load(variant)
  local palette = require("mira.palette").get(variant or M.opts.default_variant)
  -- TODO: build & apply highlights with vim.api.nvim_set_hl(0, group, spec)
  -- Keeping it empty retains stock look.
  return palette
end

return M
