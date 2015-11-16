function! Mutt()
    vnew
    terminal mutt
endfunction

command! Vimrc :e ~/.config/nvim/init.vim
command! Zshrc :e ~/.zshrc
command! S source ~/.config/nvim/init.vim
command! Mutt call Mutt()
