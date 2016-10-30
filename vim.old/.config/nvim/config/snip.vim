function! CreateSnip()
  15new .tmp.vim.snip  
endfunction

"nmap <leader>r :call CreateSnip()<cr>

augroup vim.snip
  autocmd!
  autocmd FocusLost,BufLeave,WinLeave,BufWritePost *.tmp.vim.snip :source %
  autocmd BufNewFile,BufRead *.tmp.vim.snip setlocal filetype=vim
augroup END
