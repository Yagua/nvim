local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local M = {}

M.nvim_dotfiles = function ()
  local setts = themes.get_dropdown {
    prompt_title = "~ Nvim-dotfiles ~",
    cwd = "~/.dotfiles/nvim/.config/nvim/",
    hidden = false,
    previewer = false,
    file_ignore_patterns = { "%.git" }
  }
  builtin.find_files(setts)
end

M.search_dotfiles = function ()
  local setts = themes.get_dropdown {
    prompt_title = "~ dotfiles ~",
    cwd = "~/.dotfiles/",
    hidden = true,
    previewer = false,
    file_ignore_patterns = {
      "nvim",
      "%.git"
    }
  }
  builtin.find_files(setts)
end

return M
