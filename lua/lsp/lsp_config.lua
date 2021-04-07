local lsp = require('lspconfig')

 --Utility servers
local map = function(type, key, value)
  vim.api.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
end

-- For snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
     -- Enable underline, use default values
     underline = true,
     -- Enable virtual text, override spacing to 4
     virtual_text = {
       --spacing = 4,
       --prefix = '',
     },
     -- Use a function to dynamically turn signs off
     -- and on, using buffer local variables
     signs = function(bufnr, client_id)
       local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
       -- No buffer local variable set, so just enable by default
       if not ok then
         return true
       end

       return result
     end,
     -- Disable a feature
     update_in_insert = false,
    }
)

--Diagnostics Signs
vim.fn.sign_define("LspDiagnosticsSignError",
    {text = ""})
vim.fn.sign_define("LspDiagnosticsSignWarning",
    {text = ""})
vim.fn.sign_define("LspDiagnosticsSignInformation",
    {text = ""})
vim.fn.sign_define("LspDiagnosticsSignHint",
    {text = ""})

-- configuring LSP servers
local on_attach_common = function(_)
  print("LSP Started.");
  -- GOTO mappings
  map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
  map('n','<leader>du','<cmd>lua vim.lsp.buf.definition()<CR>')
  map('n','<leader>re','<cmd>lua vim.lsp.buf.references()<CR>')
  map('n','<leader>vi','<cmd>lua vim.lsp.buf.implementation()<CR>')
  map('n','<leader>sh','<cmd>lua vim.lsp.buf.signature_help()<CR>')
  map('n','<leader>vh','<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n','<leader>gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
  map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  -- ACTION mappings
  map('n','<leader>ah',  '<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n','<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  map('n','<leader>rn',  '<cmd>lua vim.lsp.buf.rename()<CR>')
  -- Few language severs support these three
  map('n','<leader>=',  '<cmd>lua vim.lsp.buf.formatting()<CR>')
  map('n','<leader>ai',  '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
  map('n','<leader>ao',  '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
  -- Diagnostics mapping
  map('n','<leader>ee', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
  map('n','<leader>en', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  map('n','<leader>es', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
end

--=======SERVERS======
--# JS/TS
lsp.tsserver.setup{ on_attach=on_attach_common }
--# PYTHON
lsp.pyright.setup{ on_attach = on_attach_common }
--# JSON
lsp.jsonls.setup{ on_attach = on_attach_common }
--# LUA
local sumneko_root_path = vim.fn.expand('$HOME')..'/.local/servers/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"
lsp.sumneko_lua.setup{
  cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'}
      },
      workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
      }
    }
  },
  on_attach = on_attach_common
}
--# VIM
lsp.vimls.setup{ on_attach = on_attach_common }
--# YAML
--lsp.yamlls.setup{ on_attach = on_attach_common }
--# HTML
lsp.html.setup{
  on_attach = on_attach_common,
  capabilities = capabilities,
}
--# CSS
lsp.cssls.setup{
  on_attach = on_attach_common,
  capabilities = capabilities,
}
--# DOCKER
--lsp.dockerls.setup{
  --on_attach = on_attach_common,
--}
--# PHP
--lsp.intelephense.setup{
  --cmd = { "intelephense", "--stdio" },
  --filetypes = { "php" },
  --on_attach = on_attach_common
--}
--# C++/C
lsp.clangd.setup{ on_attach = on_attach_common }
--# GO
--lsp.gopls.setup{ on_attach = on_attach_common}
