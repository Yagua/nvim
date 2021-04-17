--Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with (
  vim.lsp.diagnostic.on_publish_diagnostics, {
     underline = true, -- Enable underline, use default values
     virtual_text = { -- Enable virtual text, override spacing to 4
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
