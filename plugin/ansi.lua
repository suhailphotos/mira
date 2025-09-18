-- If Nvim doesn't have a 16-color ANSI palette yet, provide one
if type(vim.g.terminal_ansi_colors) ~= "table" or #vim.g.terminal_ansi_colors < 16 then
  local ok, pal = pcall(require, "mira.palette")
  if ok then
    local P = pal.get("lilac")
    if P.ansi and #P.ansi >= 16 then
      vim.g.terminal_ansi_colors = vim.deepcopy(P.ansi)
    end
  end
end
