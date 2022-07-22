require("nvim-tree").setup({
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
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
    mappings = {
      list = {
        { key = "<CR>",           action = "edit" },
        { key = "l",              action = "edit" },
        { key = "<C-]>",          action = "cd" },
        { key = "<C-v>",          action = "vsplit" },
        { key = "<C-s>",          action = "split" },
        { key = "<C-t>",          action = "tabnew" },
        { key = "<",              action = "prev_sibling" },
        { key = ">",              action = "next_sibling" },
        { key = "h",              action = "close_node" },
        { key = "<Tab>",          action = "preview" },
        { key = "I",              action = "toggle_ignored" },
        { key = ".",              action = "toggle_dotfiles" },
        { key = "R",              action = "refresh" },
        { key = "a",              action = "create" },
        { key = "<S-D>",          action = "remove" },
        { key = "r",              action = "rename" },
        { key = "<C-r>",          action = "full_rename" },
        { key = "x",              action = "cut" },
        { key = "c",              action = "copy" },
        { key = "p",              action = "paste" },
        { key = "[c",             action = "prev_git_item" },
        { key = "]c",             action = "next_git_item" },
        { key = "-",              action = "dir_up" },
        { key = "q",              action = "close" }
      },
    },
  },
  renderer = {
    group_empty = true,
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
