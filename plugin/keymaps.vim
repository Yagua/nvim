"PERSONAL MAPS
let mapleader=" "
noremap <Leader>ww :w! <CR>
noremap <Leader>w :w <CR>
noremap <Leader>q :q <CR>
noremap <Leader>qq :q! <CR>
noremap <Leader>bx :Buffers <CR>
noremap <C-n> :NvimTreeToggle<CR>
vmap <Leader>/ <plug>NERDCommenterToggle
nmap <Leader>/ <plug>NERDCommenterToggle
nmap <Leader>s <Plug>(easymotion-s2)
nnoremap <Leader>rl :%s/-/-/g

nnoremap <Leader>h :wincmd h<CR>
nnoremap <Leader>j :wincmd j<CR>
nnoremap <Leader>k :wincmd k<CR>
nnoremap <Leader>l :wincmd l<CR>
nnoremap <Leader>u :UndotreeShow<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader><CR> :luafile ~/.config/nvim/init.lua<CR>
nnoremap <Leader>rc :edit ~/.config/nvim/init.lua<CR>
nnoremap <Leader>db :edit ~/.my.cnf<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Compe config
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <C-e> compe#close('<C-e>')
inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
                 \ compe#confirm('<CR>') : "\<c-e>\<CR>" :  "\<CR>"
