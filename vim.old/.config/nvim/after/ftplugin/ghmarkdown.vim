set tabstop=2
set softtabstop=2
set shiftwidth=2
set wrap
set linebreak
set nolist
set textwidth=80


function! CheckCheck()
  normal ^s[ 
  normal di[ix
endfunction


function! CheckNew()
  normal i- [ ] 
endfunction

nnoremap <silent> <leader>cc :call CheckCheck()<cr>
nnoremap <silent> <leader>cn :call CheckNew()<cr>



