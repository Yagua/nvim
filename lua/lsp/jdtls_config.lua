local M = {}
local server_cmd = vim.fn.expand('$HOME') .. '/.local/servers/jdtls/jdtls'

function M.setup()
  require('jdtls').start_or_attach({
    cmd = { server_cmd }
  })

  -- Utility servers
  local keymap = function(type, key, value)
    vim.api.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = true});
  end
  -- GOTO mappings
  keymap('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
  keymap('n','<leader>du','<cmd>lua vim.lsp.buf.definition()<CR>')
  keymap('n','<leader>re','<cmd>lua vim.lsp.buf.references()<CR>')
  keymap('n','<leader>vi','<cmd>lua vim.lsp.buf.implementation()<CR>')
  keymap('n','<leader>sh','<cmd>lua vim.lsp.buf.signature_help()<CR>')
  keymap('n','<leader>gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
  keymap('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  keymap('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  -- ACTION mappings
  keymap('n','<leader>ah',  '<cmd>lua vim.lsp.buf.hover()<CR>')
  keymap('n','<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  keymap('n','<leader>rn',  '<cmd>lua vim.lsp.buf.rename()<CR>')
  -- Few language severs support these three
  keymap('n','<leader>=',  '<cmd>lua vim.lsp.buf.formatting()<CR>')
  keymap('n','<leader>ai',  '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
  keymap('n','<leader>ao',  '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
  -- Diagnostics mapping
  keymap('n','<leader>ee', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
  keymap('n','<leader>en', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  keymap('n','<leader>es', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')

  keymap('n', [[<leader>oi]], [[<Cmd>lua require'jdtls'.organize_imports()<CR>]])
  keymap('n', [[<leader>av]], [[<Cmd>lua require('jdtls').extract_variable()<CR>]])
  keymap('v', [[<leader>av]], [[<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>]])
  keymap('v', [[<leader>am]], [[<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>]])
  keymap('n', [[<leader>ar]], [[<Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>]])

  local jdtls_ui = require'jdtls.ui'
  function jdtls_ui.pick_one_async(items, _, _, cb)
    require'lsputil.codeAction'.code_action_handler(nil, nil, items, nil, nil, nil, cb)
  end
  vim.cmd[[command! -buffer JdtCompile lua require('jdtls').compile()]]
  vim.cmd[[command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()]]
  vim.cmd[[command! -buffer JdtJol lua require('jdtls').jol()]]
  vim.cmd[[command! -buffer JdtBytecode lua require('jdtls').javap()]]
  vim.cmd[[command! -buffer JdtJshell lua require('jdtls').jshell()]]

end

return M
