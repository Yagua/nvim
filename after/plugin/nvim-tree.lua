require("nvim-tree").setup({
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = true,
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  view = {
    number = true,
    relativenumber = true,
    adaptive_size = false,
  },
  on_attach = function(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
      return {
        desc = "nvim-tree: " .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true,
      }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set("n", "l", api.node.open.edit, opts("Edit"))
    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close"))
    vim.keymap.set("n", ".", api.tree.toggle_hidden_filter, opts("Dotfiles"))
    vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Ignore"))
  end,
  renderer = {
    group_empty = false,
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        folder_arrow = false
      }
    }
  },
  filters = {
    dotfiles = true,
  },
})

vim.api.nvim_set_keymap("n", "<c-n>", ":NvimTreeToggle<CR>", {noremap = true})
