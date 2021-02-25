--Hightlight yanks
vim.cmd[[augroup highlight_yank]]
  vim.cmd[[autocmd!]]
  vim.cmd[[autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})]]
vim.cmd[[augroup END]]

--# SQL / require plugin client
vim.cmd[[augroup SqlFiles]]
    vim.cmd[[autocmd!]]
    vim.cmd[[autocmd FileType sql nnoremap <Leader>as A-- --defaults-group-suffix=<CR>-- -t<CR>--<CR>]]
vim.cmd[[augroup END]]

--# JAVA
vim.cmd[[augroup lsp]]
    vim.cmd[[au!]]
    vim.cmd[[au FileType java lua require'lsp.jdtls_config'.setup()]]
vim.cmd[[augroup end]]
