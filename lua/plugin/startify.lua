local opt, exec = vim.g, vim.api.nvim_exec

--set options
opt.startify_enable_special = 0
opt.startify_change_to_vcs_root = 1
opt.startify_session_delete_buffers = 1
--opt.webdevicons_enable_startify = 1
--opt.startify_fortune_use_unicode = 1
--opt.startify_custom_header = {}

--bookmarks variables
exec([[
let init = '~/.config/nvim/init.lua'
let opt = '~/.config/nvim/lua/options.lua'
let plug = '~/.config/nvim/lua/plugins.lua'
let zsh = '~/.config/zsh/.zshrc'

let g:startify_bookmarks = [{'i': init}, {'o': opt}, {'p': plug}, {'z': zsh}]

]], true)

--enable incons in startify
--vim.cmd([[
--function! StartifyEntryFormat()
        --return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
--endfunction
--]])
