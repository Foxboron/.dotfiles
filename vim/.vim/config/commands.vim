function! Mutt()
    vnew
    terminal mutt
endfunction

command! Vimrc :e ~/.vimrc
command! Zshrc :e ~/.zshrc
command! S source ~/.vimrc
command! Mutt call Mutt()
