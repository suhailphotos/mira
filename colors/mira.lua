--- --------------------------------------------------
-- Colorscheme: mira
-- --------------------------------------------------
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.g.colors_name = "mira"

require("mira").load("lilac")
