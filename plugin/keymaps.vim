" reload lua modules with plenary
command! -nargs=+ Relm :lua require("plenary.reload").reload_module("<args>")

" --exec file
function! s:executer() abort
  if &ft ==# 'lua'
    silent! write
    exe 'luafile %'
  elseif &ft ==# "vim"
    silent! write
    exe 'so %'
  endif
endfunction

nnoremap <leader>x :call <SID>executer()<CR>
