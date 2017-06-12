inoremap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>"
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

