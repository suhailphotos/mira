-- --------------------------------------------------
-- Theme API
-- --------------------------------------------------
local M = {}

M.opts = {
  default_variant = "lilac",
  ansi_mode = "palette",  -- "palette" | "emulator"
}

local function apply_ansi(P)
  if M.opts.ansi_mode ~= "palette" then return end
  local a = P.ansi
  if type(a) ~= "table" or #a ~= 16 then return end
  vim.g.terminal_ansi_colors = a
  for i = 0, 15 do
    vim.g["terminal_color_" .. i] = a[i + 1]
  end
end

-- If you ever want pure emulator colors inside :terminal:
--   require("mira").setup({ ansi_mode = "emulator" })
-- That turns off truecolor locally for terminal buffers so the emulator wins.
local function setup_emulator_passthrough()
  if M.opts.ansi_mode ~= "emulator" then return end
  vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("mira_term_passthrough", { clear = true }),
    callback = function()
      vim.opt_local.termguicolors = false
    end,
  })
end

-- When leaving 'mira', clear any ANSI overrides so other themes aren't forced
local function clear_ansi_on_switch()
  vim.api.nvim_create_autocmd("ColorSchemePre", {
    group = vim.api.nvim_create_augroup("mira_clear_ansi_on_switch", { clear = true }),
    callback = function(args)
      if (vim.g.colors_name or "") == "mira" and args.match ~= "mira" then
        vim.g.terminal_ansi_colors = nil
        for i = 0, 15 do vim.g["terminal_color_" .. i] = nil end
      end
    end,
  })
end

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
  setup_emulator_passthrough()
  clear_ansi_on_switch()
end

function M.load(variant)
  local P = require("mira.palette").get(variant or M.opts.default_variant)
  apply_ansi(P)
  require("mira.highlights").apply(P)
  return P
end

return M
