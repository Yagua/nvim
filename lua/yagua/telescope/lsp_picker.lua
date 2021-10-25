local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local dotfiles = function()
  local opts = {}
  pickers:new(opts, {
    prompt_title = "dotfiles",
    cwd = "~/.config/",
    finder = finders.new_table {
      results = {"t"}
    },
  }):find()
end
