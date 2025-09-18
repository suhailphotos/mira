-- --------------------------------------------------
-- Theme API
-- --------------------------------------------------
local M = {}

M.opts = { default_variant = "lilac", use_terminal_ansi = true }

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
end

function M.load(variant)
  local P = require("mira.palette").get(variant or M.opts.default_variant)
  if M.opts.use_terminal_ansi then
    local g = vim.g.terminal_ansi_colors
    if type(g) == "table" and #g >= 16 then P.ansi = g end
  end
  require("mira.highlights").apply(P)
  return P
end

return M
