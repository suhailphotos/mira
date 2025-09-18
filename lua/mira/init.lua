-- --------------------------------------------------
-- Theme API
-- --------------------------------------------------
local M = {}

M.opts = {
  default_variant = "lilac",
  ansi_only = true,     -- <— key: use terminal palette, no hex
}

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
end

function M.load(variant)
  -- ANSI-only mode: let the terminal map colors; don't use truecolor.
  if M.opts.ansi_only then
    vim.g.mira_ansi_only = true
    vim.opt.termguicolors = false
  else
    vim.g.mira_ansi_only = false
    vim.opt.termguicolors = true
  end

  local P = require("mira.palette").get(variant or M.opts.default_variant)
  -- In ansi_only mode we don't need P.ansi at all; indices are enough.
  require("mira.highlights").apply(P)
  return P
end

return M
