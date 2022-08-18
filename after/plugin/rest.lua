local keymap = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }

require("rest-nvim").setup({
  result_split_horizontal = false,
  result_split_in_place = "left",
  skip_ssl_verification = false,
  highlight = {
    enabled = true,
    timeout = 150,
  },
  result = {
    show_url = true,
    show_http_info = true,
    show_headers = true,
    formatters = {
      json = "jq",
    },
  },
  jump_to_request = false,
  env_file = ".env",
  custom_dynamic_variables = {},
  yank_dry_run = true,
})

keymap('n', '<Leader>rs', ':lua require("rest-nvim").run()<CR>', options)
keymap('n', '<Leader>rS', ':lua require("rest-nvim").run(true)<CR>', options)
keymap('n', '<Leader>rl', ':lua require("rest-nvim").last()<CR>', options)
