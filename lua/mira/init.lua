-- --------------------------------------------------
-- Theme API
-- --------------------------------------------------
local M = {}

M.opts = { default_variant = "lilac" }

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
end

function M.load(variant)
  local P = require("mira.palette").get(variant or M.opts.default_variant)
  require("mira.highlights").apply(P)
  return P
end

return M
