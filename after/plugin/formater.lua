require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
        -- prettier
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath",
            vim.api.nvim_buf_get_name(0),
            '--single-quote'
          },
          stdin = true
        }
      end
    },
    python = {
      function ()
        return {
          exe = "black",
          args = {"-q", "-l", "80", "-",},
          stdin = true,
        }
      end
    }
  }
})

local options = {expr = false, silent = true, noremap = true}
vim.api.nvim_set_keymap("n", "<leader>fo", ":Format<CR>", options)
