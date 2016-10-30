function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

function! Keepjumps(command)
  let winview = winsaveview()
  execute "keepjumps normal! " . a:command
  call winrestview(winview)
endfunction
nnoremap <leader>= :call Keepjumps("gg=G")<CR>

function! Scp(serv)
  let name = input('Filname: ') 
  let f = substitute(system("mktemp"), "\n*$", '', '')
  silent execute '!chmod 644 ' . f
  silent execute 'w >>' f
  silent execute '!scp ' . f . ' ' . a:serv . name
  silent execute '!rm ' . f
  echo 
endfunction 
map <leader>pw :call Scp("vulpes:www/")<cr>

function! ScpEdit(serv)
  let name = input('Filname: ') 
  silent execute '!rcp scp://' . a:serv . name
  echo
endfunction 
map <leader>pe :call ScpEdit("vulpes:www/")<cr>
