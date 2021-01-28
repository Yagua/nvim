local lsp = require'lspconfig'

 --Utility servers
local map = function(type, key, value)
    vim.fn.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
end

-- For snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

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

-- configuring LSP servers
local on_attach_common = function(_)
    print("LSP started.");
    --require'completion'.on_attach()

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
lsp.tsserver.setup{on_attach=on_attach_common}
--# PYTHON
lsp.pyright.setup{ on_attach = on_attach_common }
--# JSON
lsp.jsonls.setup{ on_attach = on_attach_common }
--# LUA
lsp.sumneko_lua.setup{
    cmd = {'lua-language-server'},
    filetype = {'lua'},
    on_attach = on_attach_common
}
--# VIM
--lsp.vimls.setup{ on_attach = on_attach_common }
--# YAML
--lsp.yamlls.setup{ on_attach = on_attach_common }
--# HTML
lsp.html.setup{
    on_attach=on_attach_common,
    capabilities = capabilities,
}
--# CSS
lsp.cssls.setup{
    on_attach=on_attach_common,
    capabilities = capabilities,
}
--# DOCKER
--lsp.dockerls.setup{
    --on_attach=on_attach_common,
--}
--# PHP
--lsp.intelephense.setup{
--cmd = { "intelephense", "--stdio" },
--filetypes = { "php" },
--on_attach=on_attach_common
--}
--# C++/C
lsp.clangd.setup{ on_attach =on_attach_common }
--# GO
--lsp.gopls.setup{ on_attach=on_attach_common }
--====================

--local system_name
--if vim.fn.has("mac") == 1 then
  --system_name = "macOS"
--elseif vim.fn.has("unix") == 1 then
  --system_name = "Linux"
--elseif vim.fn.has('win32') == 1 then
  --system_name = "Windows"
--else
  --print("Unsupported system for sumneko")
--end

 --nvim-lsputils configuration
--vim.g.lsp_utils_location_opts = {
    --height = 24,
    --mode = 'split',
    --list = {
    --border = true,
    --numbering = true
    --},
    --preview = {
    --title = 'Location Preview',
    --border = true,
    --},
--}


--vim.g.lsp_utils_symbols_opts = {
    --height = 24,
    --mode = 'editor',
    --list = {
    --border = true,
    --numbering = false,
    --},
    --preview = {
    --title = 'Symbols Preview',
    --border = true,
    --},
    --prompt = {}
--}
--vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
--vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
--vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
--vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
--vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
--vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
--vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
--vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

--vim.g.diagnostic_enable_virtual_text = 1

--local function lsp_reload(buffer)
    --vim.lsp.stop_client(vim.lsp.get_active_clients(buffer))
    --vim.cmd("edit")
--end

--local function lsp_stop(buffer)
    --vim.lsp.diagnostic.clear(buffer)
    --vim.lsp.stop_client(vim.lsp.get_active_clients(buffer))
--end

----require'compe'.setup {
  ----enabled = true,
  ----debug = false,
  ------ min_length = 1,
  ----preselect = 'disable',

  ----source = {
    ----path = {
	----priority = 9
    ----},
    ----buffer = {
	----priority = 8
    ----},
    ----vsnip = {
	----priority = 9
    ----},
    ----nvim_lsp = {
	----priority = 10,
	----sort = false
    ----},
    ------ nvim_lua = { ... overwrite source configuration ... };
  ----};
----}

--return{
    --lsp_reload = lsp_reload,
    --lsp_stop = lsp_stop
--}
