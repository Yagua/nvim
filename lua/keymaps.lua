local setmap = vim.api.nvim_set_keymap

vim.g.mapleader = " "
setmap("n", "<leader>ww", ":w!<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>qq", ":q!<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<C-n>", ":NvimTreeToggle<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>/", "<plug>NERDCommenterToggle", {expr = false, silent = false, noremap = false})
setmap("v", "<leader>/", "<plug>NERDCommenterToggle", {expr = false, silent = false, noremap = false})
setmap("n", "<leader>s", "<plug>(easymotion-s2)", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>h", ":wincmd h<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>l", ":wincmd l<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>j", ":wincmd j<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>k", ":wincmd k<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>u", ":UndotreeShow<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>+", "vertical resize +5<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>-", "vertical resize -5<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader><CR>", ":luafile $MYVIMRC<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>ma", ":MaximizerToggle!<CR>", {expr = false, silent = false, noremap = true})
