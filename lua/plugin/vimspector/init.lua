--Thanks Primeangen
local exec, setmap = vim.api.nvim_exec, vim.api.nvim_set_keymap

exec([[
fun! GotoWin(id)
  call win_gotoid(a:id)
  MaximizerToggle
endfun
]], true)

setmap("n", "<leader>dd", ":call vimspector#Launch()<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>dc", ":call GotoWin(g:vimspector_session_windows.code)<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>dv", ":call GotoWin(g:vimspector_session_windows.variables)<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>dw", ":call GotoWin(g:vimspector_session_windows.watches)<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>ds", ":call GotoWin(g:vimspector_session_windows.stack_trace)<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>do", ":call GotoWin(g:vimspector_session_windows.output)<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>de", ":call vimspector#Reset()<CR>", {expr = false, silent = false, noremap = true})
setmap("n", "<leader>dt", ":call GotoWin(g:vimspector_session_windows.tagpage)<CR>", {expr = false, silent = false, noremap = true})

setmap("n", "<leader>clb", ":call vimspector#CleanLineBreakpoint()<CR>", {expr = false, silent = false, noremap = true})

setmap("n", "<leader>dl", "<Plug>VimspectorStepInto", {expr = false, silent = false, noremap = false})
setmap("n", "<leader>dj", "<Plug>VimspectorStepOver", {expr = false, silent = false, noremap = false})
setmap("n", "<leader>dk", "<Plug>VimspectorStepOut", {expr = false, silent = false, noremap = false})
setmap("n", "<leader>d_", "<Plug>VimspectorRestart", {expr = false, silent = false, noremap = false})
setmap("n", "<leader>con", ":call vimspector#Continue()<CR>", {expr = false, silent = false, noremap = true})

setmap("n", "<leader>drc", "<Plug>VimspectorRunToCursor", {expr = false, silent = false, noremap = false})
setmap("n", "<leader>dpc", "<Plug>VimspectorToggleBreakpoint", {expr = false, silent = false, noremap = false})
setmap("n", "<leader>dbc", "<Plug>VimspectorToggleConditionalBreakpoint", {expr = false, silent = false, noremap = false})
