--Hightlight yanks
vim.cmd[[augroup highlight_yank]]
  vim.cmd[[autocmd!]]
  vim.cmd[[autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})]]
vim.cmd[[augroup END]]

--# JAVA
vim.cmd[[augroup jdtls_lsp]]
  vim.cmd[[autocmd!]]
  vim.cmd[[autocmd FileType java lua require'lsp.jdtls_config'.setup()]]
vim.cmd[[augroup end]]
