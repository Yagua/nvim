setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

" go.nvim keymaps
nnoremap <leader>Gr <cmd>GoRun<CR>
nnoremap <leader>GA <cmd>GoModTidy<CR>
nnoremap <leader>Gb <cmd>GoBuild<CR>
nnoremap <leader>Gt <cmd>GoTestFunc<CR>
nnoremap <leader>GT <cmd>GoTestFile<CR>
nnoremap <leader>GC <cmd>GoCoverage -m<CR>
nnoremap <leader>Gp <cmd>GoTestPkg<CR>
nnoremap <leader>Gd <cmd>GoDoc<CR>
nnoremap <leader>Gf <cmd>GoFillStruct<CR>
nnoremap <leader>GD <cmd>GoDebug -t<CR>
nnoremap <leader>Gi <cmd>GoImports<CR>
nnoremap <leader>GF <cmd>GoFmt<CR>
nnoremap <leader>Ga <cmd>GoAddTest<CR>
nnoremap <leader>Gg <cmd>GoAddTag<CR>
nnoremap <leader>Gl <cmd>GoClearTag<CR>
nnoremap <leader>GI <cmd>GoImpl<CR>
nnoremap <leader>Ge <cmd>GoIfErr<CR>
nnoremap <leader>GR <cmd>GoGenReturn<CR>
nnoremap <leader>GL <cmd>GoToggleInlay<CR>
nnoremap <leader>Gm <cmd>GoCmt<CR>
