local neogit = require("neogit")
local keymap = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }

neogit.setup {
  disable_signs = false,
  disable_hint = false,
  disable_context_highlighting = false,
  disable_commit_confirmation = true,
  auto_refresh = true,
  disable_builtin_notifications = false,
  use_magit_keybindings = false,
  kind = "tab",
  commit_popup = {
    kind = "split",
  },
  popup = {
    kind = "split",
  },
  -- customize displayed signs
  signs = {
    section = { ">", "v" },
    item = { ">", "v" },
    hunk = { "", "" },
  },
  mappings = {
    status = {}
  }
}

keymap("n", "<leader>no", ":lua require('neogit').open()<CR>", options)
