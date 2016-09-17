function! Wordcount()
  execute ":silent ! texcount " . @% . " | grep -oEi \"Words in text:.*\""
endfunction

command! WordCount call Wordcount()
set textwidth=80
set spell
set spelllang=en_us

nnoremap <C-N> ]s
nnoremap <C-P> [s
nnoremap <leader>ss z=
nnoremap <leader>sg zg
nnoremap <leader>sw zw
