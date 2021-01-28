set splitright
function! OpenTerminal() abort
  " move to right most buffer
  execute "normal \<C-l>"
  execute "normal \<C-l>"
  execute "normal \<C-l>"
  execute "normal \<C-l>"

  let bufNum = bufnr("%")
  let bufType = getbufvar(bufNum, "&buftype", "not found")
  let typeFile =  &filetype

  if bufType == "terminal"
    " close existing terminal
    execute "q"
  else
    if typeFile == "java"
        execute "vsp term://java %"
    elseif typeFile == "javascript"
        execute "vsp term://node %"
    elseif typeFile == "php"
        execute "vsp term://php %"
    elseif typeFile == "lua"
        execute "vsp term://lua5.4 %"
    elseif typeFile == "python"
        execute "vsp term://python %"
    elseif typeFile == "lua"
        execute "vsp term://lua5.4 %"
    else
        echom "Undefine FileType"
    endif

    " turn off numbers
    execute "set nonu"
    execute "set nornu"

    " toggle insert on enter/exit
    "silent au BufLeave <buffer> stopinsert!
    "silent au BufWinEnter,WinEnter <buffer> startinsert!

    " set maps inside terminal buffer
    execute "tnoremap <buffer> <C-h> <C-\\><C-n><C-w><C-h>"
    execute "tnoremap <buffer> <C-t> <C-\\><C-n>:q<CR>"
    execute "tnoremap <buffer> <C-\\><C-\\> <C-\\><C-n>"

    "startinsert!
  endif
endfunction
nnoremap <leader>tr :call OpenTerminal()<CR>
