local keymap = vim.api.nvim_set_keymap

local opts = {noremap = true}
keymap("n", "<leader>ps", [[:lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>]], opts)
keymap("n", "<C-p>", [[:lua require('telescope.builtin').git_files()<CR>]], opts )
keymap("n", "<leader>sg", [[:lua require('telescope.builtin').find_files()<CR>]], opts )
keymap("n", "<leader>pw", [[:lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>]], opts )
keymap("n", "<leader>bk", [[:lua require('telescope.builtin').buffers()<CR>]], opts )
keymap("n", "<leader>vh", [[:lua require('telescope.builtin').help_tags()<CR>]], opts )
