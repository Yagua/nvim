local setmap = vim.api.nvim_set_keymap

setmap("n", "<leader>ps", [[:lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>]], { noremap = true})
setmap("n", "<C-p>", [[:lua require('telescope.builtin').git_files()<CR>]], {noremap = true})
setmap("n", "<leader>sg", [[:lua require('telescope.builtin').find_files()<CR>]], {noremap = true})
setmap("n", "<leader>pw", [[:lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>]], {noremap = true})
setmap("n", "<leader>bk", [[:lua require('telescope.builtin').buffers()<CR>]], {noremap = true})
setmap("n", "<leader>vh", [[:lua require('telescope.builtin').help_tags()<CR>]], {noremap = true})
