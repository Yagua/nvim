local M = {}

-- our picker function: colors
M.search_dotfiles = function ()
  require("telescope.builtin").find_files {
    prompt_title = "~ dotfiles ~",
    cwd = "~/.config/nvim/",
    hidden = false
  }
end

return M
