" Starts a repl using vim-proc
" Jacked some logic from leiningen-vim to autorun whenever a fireplace command
" is issued without a connection.
" If someone does see this and wonder WTF i'm doing, i got no idea.


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
  silent execute '!scp ' . f . ' ' . serv . name
  silent execute '!rm ' . f
endfunction 
map <leader>pw :call Scp("trinity:www/")<cr>

function! ScpEdit(serv)
  let name = input('Filname: ') 
  silent execute ':e scp://' . serv . name
endfunction 
map <leader>pe :call ScpEdit("trinity/www/")<cr>

function! s:detect(file) abort
  if !exists('b:leiningen_root')
    let root = simplify(fnamemodify(a:file, ':p:s?[\/]$??'))
    if !isdirectory(fnamemodify(root, ':h'))
      return ''
    endif
    let previous = ""
    while root !=# previous
      if filereadable(root . '/project.clj') && join(readfile(root . '/project.clj', '', 50)) =~# '(\s*defproject'
        let b:leiningen_root = root
        let b:java_root = root
        break
      endif
      let previous = root
      let root = fnamemodify(root, ':h')
    endwhile
  endif
  return exists('b:leiningen_root')
endfunction


function! s:portfile() abort
  if !exists('b:leiningen_root')
    return ''
  endif

  let root = b:leiningen_root
  let portfiles = [root.'/.nrepl-port', root.'/target/repl-port', root.'/target/repl/repl-port']

  for f in portfiles
    if getfsize(f) > 0
      return f
    endif
  endfor
  return ''
endfunction


function! ReplFn() abort
    call s:detect(expand('%:p'))
    let portfile = s:portfile()
    if empty(portfile)
        execute "call vimproc#popen2('lein repl')"
    else
        return {}
    endif
    let i = 0
    let portfile = s:portfile()
    while empty(portfile) && i < 300 && !getchar(0)
        let i += 1
        sleep 100m
        let portfile = s:portfile()
    endwhile
    return empty(portfile) ? {} :
        \ fireplace#register_port_file(portfile, b:leiningen_root)
endfunction
command! Repl call ReplFn()


augroup leiningen
    autocmd!
    autocmd User FireplacePreConnect call ReplFn()
    autocmd User FireplacePreConnect nnoremap <C-Space> :Eval<cr>
augroup END
