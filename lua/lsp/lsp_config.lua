-- setup lsp
local lsp = require('lspconfig')

-- external modules
require('lsp.diagnostics')

-- For snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

 --Utility servers

-- configuring LSP servers
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  local function buf_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  print("[LSP]: Server Started");

  buf_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_keymap('n', '<leader>du', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_keymap('n', '<leader>re', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_keymap('n', '<leader>vi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_keymap('n', '<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_keymap('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_keymap('n', '<leader>gw', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  buf_keymap('n', '<leader>gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  -- ACTION mappings
  buf_keymap('n', '<leader>ah', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- Few language severs support these three
  buf_keymap('n', '<leader>=',  '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_keymap('n', '<leader>ai', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
  buf_keymap('n', '<leader>ao', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)
  -- Diagnostics mapping
  buf_keymap('n', '<leader>ee', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_keymap('n', '<leader>en', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_keymap('n', '<leader>es', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
end

--=======SERVERS======
--# LUA
local sumneko_root_path = os.getenv('HOME')..'/.local/servers/lua-language-server'
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
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
          }
        }
      }
    },
  on_attach = on_attach
}
--# JS/TS
lsp.tsserver.setup{
  cmd = {"typescript-language-server", "--stdio"},
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx"
    },
  on_attach = on_attach
}
--# PYTHON
lsp.pyls.setup{
  plugins = {
    pyls_mypy = {
      enabled = true,
      live_mode = false,
    },
  },
  on_attach = on_attach
}
--# JSON
--lsp.jsonls.setup{ on_attach = on_attach }
--# VIM
lsp.vimls.setup{ on_attach = on_attach }
--# C++/C
lsp.clangd.setup{ on_attach = on_attach }
--# HTML
lsp.html.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
--# CSS
lsp.cssls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
--# DOCKER
--lsp.dockerls.setup{
  --on_attach = on_attach,
--}
----# PHP
--lsp.intelephense.setup{
  --cmd = { "intelephense", "--stdio" },
  --filetypes = { "php" },
  --on_attach = on_attach
--}
----# GO
--lsp.gopls.setup{ on_attach = on_attach}
----# YAML
--lsp.yamlls.setup{ on_attach = on_attach }

--lsp.sqlls.setup{
  --cmd = {"sql-language-server", "up", "--method", "stdio"},
  --on_attach = on_attach,
  --capabilities = capabilities,
--}
