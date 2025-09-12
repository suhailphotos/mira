-- Minimal “no-op” colorscheme. Safe to call anytime.
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.g.colors_name = "mira"

-- Intentionally no highlights yet. This keeps the UI stock.
-- Later you'll: require("mira").load("lilac") and apply groups here.
