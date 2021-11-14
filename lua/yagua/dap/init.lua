local M = {}
local dap = require("dap")
local keymap = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }

dap.defaults.fallback.external_terminal = {
  command = '/usr/bin/alacritty',
  args = {'-e'},
}

M.setup = function()
--java
dap.configurations.java = {
  {
    type = 'java',
    name = "Debug (Attach) - Remote",
    request = 'attach',
    hostName = "127.0.0.1",
    port = 5005,
  },
  {
    type = 'java',
    name = "Debug Non-Project class",
    request = 'launch',
    program = "${file}",
  },
}
end

--vim.fn.sign_define('DapBreakpoint', {text='B', texthl='', linehl='', numhl=''})
--vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "", linehl = "", numhl = "" })
--vim.fn.sign_define('DapBreakpointRejected', {text='R', texthl='', linehl='', numhl=''})
--vim.fn.sign_define('DapLogPoint', {text='L', texthl='', linehl='', numhl=''})
--vim.fn.sign_define('DapStopped', {text='→', texthl='', linehl='debugPC', numhl=''})

keymap('n', '<F4>', ':lua require"dap".disconnect({ terminateDebuggee = true });require"dap".close()<CR>', options)
keymap('n', '<leader>db', ':lua require"dap".toggle_breakpoint()<CR>', options)
keymap('n', '<leader>dB', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", options)
keymap('n', '<leader>de', ':lua require"dap".set_exception_breakpoints({"all"})<CR>', options)
keymap('n', '<leader>dp', ':lua require"dap".toggle_breakpoint(nil, nil, vim.fn.input("Log point message: "), true)<CR>', options)
keymap('n', '<leader>so', ':lua require"dap".step_out()<CR>', options)
keymap('n', '<leader>si', ':lua require"dap".step_into()<CR>', options)
keymap('n', '<leader>sq', ':lua require"dap".step_over()<CR>', options)
keymap('n', '<leader>co', ':lua require"dap".continue()<CR>', options)
keymap('n', '<leader>dk', ':lua require"dap".up()<CR>', options)
keymap('n', '<leader>dj', ':lua require"dap".down()<CR>', options)
keymap('n', '<leader>dl', ':lua require"dap".run_last()<CR>', options)
keymap('n', '<leader>dc', ':lua require"dap".run_to_cursor()<CR>', options)
keymap('n', '<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR>', options)
keymap('n', '<leader>di', ':lua require"dap.ui.variables".hover()<CR>', options)
keymap('n', '<leader>dv', ':lua require"dap.ui.variables".visual_hover()<CR>', options)
keymap('n', '<leader>dm', ':lua require"dap.ui.variables".scopes()<CR>', options)
keymap('n', '<leader>dh', ':lua require"dap.ui.widgets".hover()<CR>', options)
keymap('v', '<leader>dh', ':lua require"dap.ui.widgets".hover(require("dap.utils").get_visual_selection_text)<CR>', options)
keymap('n', '<leader>ds', ':lua local w=require"dap.ui.widgets";w.centered_float(w.scopes)<CR>', options)
keymap('n', '<leader>dS', ':lua local w=require"dap.ui.widgets";w.centered_float(w.frames)<CR>', options)

M.setup()

return M
