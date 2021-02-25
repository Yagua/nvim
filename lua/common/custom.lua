--DIAGNOSTICS SIGNS
vim.fn.sign_define("LspDiagnosticsSignError",
    {text = ""})
vim.fn.sign_define("LspDiagnosticsSignWarning",
    {text = ""})
vim.fn.sign_define("LspDiagnosticsSignInformation",
    {text = ""})
vim.fn.sign_define("LspDiagnosticsSignHint",
    {text = ""})

-- ICONS FOR COMPLETION
require('lspkind').init({
     with_text = true,
     symbol_map = {
       Text = '',
       Method = '',
       Function = '',
       Constructor = '',
       Variable = '[]',
       Class = ' ',
       Interface = 'ﰮ',
       Module = '',
       Property = '',
       Unit = '塞',
       Value = '',
       Enum = '練',
       Keyword = '',
       Snippet = '',
       Color = '',
       File = '',
       Folder = 'ﱮ',
       EnumMember = '練',
       Constant = '',
       Struct = '',
       Event = '',
       Oporator = '',
       TypeParameter = '<>'
     },
})
