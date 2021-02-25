"PERSONAL MAPS
let mapleader=" "
noremap <Leader>ww :w! <CR>
noremap <Leader>w :w <CR>
noremap <Leader>q :q <CR>
noremap <Leader>qq :q! <CR>
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
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader><CR> :luafile ~/.config/nvim/init.lua<CR>
nnoremap <Leader>rc :edit ~/.config/nvim/init.lua<CR>
nnoremap <Leader>db :edit ~/.my.cnf<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
