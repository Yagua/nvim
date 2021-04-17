--Thanks Primeangen
local exec, keymap = vim.api.nvim_exec, vim.api.nvim_set_keymap

exec([[
fun! GotoWin(id)
  call win_gotoid(a:id)
  MaximizerToggle
endfun
]], true)

local optnore = {expr = false, silent = false, noremap = true}
local opts = {expr = false, silent = false, noremap = true}
keymap("n", "<leader>dd", ":call vimspector#Launch()<CR>", optnore )
keymap("n", "<leader>dc", ":call GotoWin(g:vimspector_session_windows.code)<CR>", optnore )
keymap("n", "<leader>dv", ":call GotoWin(g:vimspector_session_windows.variables)<CR>", optnore )
keymap("n", "<leader>dw", ":call GotoWin(g:vimspector_session_windows.watches)<CR>", optnore )
keymap("n", "<leader>ds", ":call GotoWin(g:vimspector_session_windows.stack_trace)<CR>", optnore )
keymap("n", "<leader>do", ":call GotoWin(g:vimspector_session_windows.output)<CR>", optnore )
keymap("n", "<leader>de", ":call vimspector#Reset()<CR>", optnore )
keymap("n", "<leader>dt", ":call GotoWin(g:vimspector_session_windows.tagpage)<CR>", optnore )

keymap("n", "<leader>clb", ":call vimspector#CleanLineBreakpoint()<CR>", optnore )

keymap("n", "<leader>dl", "<Plug>VimspectorStepInto", opts )
keymap("n", "<leader>dj", "<Plug>VimspectorStepOver", opts )
keymap("n", "<leader>dk", "<Plug>VimspectorStepOut", opts )
keymap("n", "<leader>d_", "<Plug>VimspectorRestart", opts )
keymap("n", "<leader>con", ":call vimspector#Continue()<CR>", opts )

keymap("n", "<leader>drc", "<Plug>VimspectorRunToCursor", opts )
keymap("n", "<leader>dpc", "<Plug>VimspectorToggleBreakpoint", opts )
keymap("n", "<leader>dbc", "<Plug>VimspectorToggleConditionalBreakpoint", opts )
