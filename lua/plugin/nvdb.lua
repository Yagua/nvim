--local nvdb_client = require("nvimdb")
local setmap = vim.api.nvim_set_keymap
local options = { expr = false, silent = false, noremap = true }
--nvdb_client.view.setup {}
--nvdb_client.runner.setup {}

setmap("v", "<Leader>rs", ":lua require('nvimdb').selector.get_selection()<CR>", options)
setmap("n", "<Leader>mm", ":lua require('nvimdb').selector.get_line()<CR>", options)
setmap("n", "<C-l>",      ":lua require('nvimdb').view:toggle_win()<CR>", options)
