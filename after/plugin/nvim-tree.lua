local opt = vim.g
opt.nvim_tree_quit_on_open = 1
opt.nvim_tree_indent_markers = 1
opt.nvim_tree_hide_dotfiles = 1

-- following options are the default
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  open_on_tab         = false,
  auto_close          = false,
  hijack_cursor       = false,
  update_cwd          = false,
  diagnostics     = {
    enable = false,
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {}
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd  = nil,
    args = {}
  },
  view = {
    width = 30,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {
        { key = "<CR>",           cb = tree_cb("edit") },
        { key = "t",              cb = tree_cb("edit") }, --custom key
        { key = "o",              cb = tree_cb("edit") },
        { key = "<2-LeftMouse>",  cb = tree_cb("edit") },
        { key = "<2-RightMouse>", cb = tree_cb("cd") },
        { key = "<C-]>",          cb = tree_cb("cd") },
        { key = "<C-v>",          cb = tree_cb("vsplit") },
        { key = "<C-x>",          cb = tree_cb("split") },
        { key = "<C-s>",          cb = tree_cb("split") }, --custom key
        { key = "<C-t>",          cb = tree_cb("tabnew") },
        { key = "<",              cb = tree_cb("prev_sibling") },
        { key = ">",              cb = tree_cb("next_sibling") },
        { key = "<BS>",           cb = tree_cb("close_node") },
        { key = "h",              cb = tree_cb("close_node") }, -- custom key
        { key = "<S-CR>",         cb = tree_cb("close_node") },
        { key = "<Tab>",          cb = tree_cb("preview") },
        { key = "I",              cb = tree_cb("toggle_ignored") },
        { key = "H",              cb = tree_cb("toggle_dotfiles") },
        { key = "R",              cb = tree_cb("refresh") },
        { key = "a",              cb = tree_cb("create") },
        { key = "d",              cb = tree_cb("remove") },
        { key = "r",              cb = tree_cb("rename") },
        { key = "<C-r>",          cb = tree_cb("full_rename") },
        { key = "x",              cb = tree_cb("cut") },
        { key = "c",              cb = tree_cb("copy") },
        { key = "p",              cb = tree_cb("paste") },
        { key = "[c",             cb = tree_cb("prev_git_item") },
        { key = "]c",             cb = tree_cb("next_git_item") },
        { key = "-",              cb = tree_cb("dir_up") },
        { key = "q",              cb = tree_cb("close") }
      }
    }
  }
}
