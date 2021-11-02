local augroups = {}

--Hightlight yanks
augroups.highlight_yank = [[
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END
]]

--# Java
augroups.jdtls_lsp = [[
augroup jdtls_lsp
  autocmd!
  autocmd FileType java lua require('yagua.lsp.jdtls_config').setup_jdtls()
augroup end
]]

for _, augroup in pairs(augroups) do
  vim.api.nvim_exec(augroup, true)
end
