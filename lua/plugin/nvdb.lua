local setmap = vim.api.nvim_set_keymap
local options = { expr = false, silent = false, noremap = true }

vim.g.nvimdb_view_name = "NvimDB"
vim.g.nvimdb_view_position = "botright"
vim.g.nvimdb_add_filetypes = {'javascript', 'html'}

setmap("v", "<Leader>rs", ":RunQuerySel<CR>", options)
setmap("n", "<Leader>mm", ":RunQueryLn<CR>", options)
setmap("n", "<C-l>",      ":ToggleViewer<CR>", options)
