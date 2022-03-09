-- local nvim_db = require("nvimdb")
--
-- nvim_db.set_view_options {
--  view_name = "Custom",
--  winopt = {}
-- }
-- nvim_db.add_filetypes {
--  "java"
-- }
--

local setmap = vim.api.nvim_buf_set_keymap
local options = { expr = false, silent = true, noremap = true }

local attach_nvim_ks = function()
  setmap(0, "v", "<Leader>rs", ":RunQuerySel<CR>", options)
  setmap(0, "n", "<Leader>mm", ":RunQueryLn<CR>", options)
  setmap(0, "n", "<Leader>tc", ":ToggleViewer<CR>", options)
end

local nvimdbgp = vim.api.nvim_create_augroup("nvim_db_attach_ks", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sql",
  callback =  attach_nvim_ks,
  group = nvimdbgp
})
