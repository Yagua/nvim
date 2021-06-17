local setmap = vim.api.nvim_set_keymap
local optnore = {expr = false, silent = false, noremap = true}
local opts = {expr = false, silent = false, noremap = false }

setmap("n", "<C-n>", ":NvimTreeToggle<CR>", optnore )
setmap("n", "<leader>/", "<plug>NERDCommenterToggle", opts )
setmap("v", "<leader>/", "<plug>NERDCommenterToggle", opts )
setmap("n", "<leader>h", ":wincmd h<CR>", optnore )
setmap("n", "<leader>l", ":wincmd l<CR>", optnore )
setmap("n", "<leader>j", ":wincmd j<CR>", optnore )
setmap("n", "<leader>k", ":wincmd k<CR>", optnore )
setmap("n", "<leader>u", ":UndotreeShow<CR>", optnore )
setmap("n", "<leader>+", ":vertical resize +5<CR>", optnore )
setmap("n", "<leader>-", ":vertical resize -5<CR>", optnore )
setmap("n", "<leader><CR>", ":luafile $MYVIMRC<CR>", optnore )
setmap("n", "<leader>ma", ":MaximizerToggle!<CR>", optnore )
setmap("n", "<leader>y", "\"+y", optnore)
setmap("v", "<leader>y", "\"+y", optnore)
setmap("v", "<leader>Y", "gg\"+yG", optnore)
