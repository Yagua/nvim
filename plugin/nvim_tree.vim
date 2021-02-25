let g:nvim_tree_disable_netrw = 0
let g:nvim_tree_hijack_netrw = 0
let g:nvim_tree_quit_on_open = 1
"let g:nvim_tree_follow = 1
let g:nvim_tree_hide_dotfiles = 1
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ }

lua <<EOF

local function get_lua_cb(cb_name)
  return string.format(":lua require'nvim-tree'.on_keypress('%s')<CR>", cb_name)
end

    vim.g.nvim_tree_bindings = {
        ["<CR>"]           = get_lua_cb("edit"),
        ["t"]              = get_lua_cb("edit"), --custom key
        ["o"]              = get_lua_cb("edit"),
        ["<2-LeftMouse>"]  = get_lua_cb("edit"),
        ["<2-RightMouse>"] = get_lua_cb("cd"),
        ["<C-]>"]          = get_lua_cb("cd"),
        ["<C-v>"]          = get_lua_cb("vsplit"),
        ["<C-x>"]          = get_lua_cb("split"),
        ["<C-s>"]          = get_lua_cb("split"), --custom key
        ["<C-t>"]          = get_lua_cb("tabnew"),
        ["<BS>"]           = get_lua_cb("close_node"),
        ["<S-CR>"]         = get_lua_cb("close_node"),
        ["h"]              = get_lua_cb("close_node"), --custom key
        ["<Tab>"]          = get_lua_cb("preview"),
        ["I"]              = get_lua_cb("toggle_ignored"),
        ["H"]              = get_lua_cb("toggle_dotfiles"),
        ["R"]              = get_lua_cb("refresh"),
        ["a"]              = get_lua_cb("create"),
        ["d"]              = get_lua_cb("remove"),
        ["r"]              = get_lua_cb("rename"),
        ["<C-r>"]          = get_lua_cb("full_rename"),
        ["x"]              = get_lua_cb("cut"),
        ["c"]              = get_lua_cb("copy"),
        ["p"]              = get_lua_cb("paste"),
        ["[c"]             = get_lua_cb("prev_git_item"),
        ["]c"]             = get_lua_cb("next_git_item"),
        ["-"]              = get_lua_cb("dir_up"),
        ["q"]              = get_lua_cb("close"),
    }
EOF
