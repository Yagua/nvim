nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <A-h> :wincmd h<CR>
nnoremap <A-n> :wincmd l<CR>
nnoremap <A-t> :wincmd j<CR>
nnoremap <A-c> :wincmd k<CR>
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <Right> gt
nnoremap <Left> gT

nnoremap <A-,> <C-W>5<
nnoremap <A-.> <C-W>5>
nnoremap <C-,> <C-W><
nnoremap <C-.> <C-W>>
nnoremap <Leader>= <C-W>=

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>ma :MaximizerToggle!<CR>

" Terminal keymaps
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-n> <C-\><C-n><C-w>j
tnoremap <A-t> <C-\><C-n><C-w>k
tnoremap <A-c> <C-\><C-n><C-w>l
