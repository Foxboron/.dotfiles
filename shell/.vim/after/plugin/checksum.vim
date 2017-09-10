" I'm lazy
function! GetChecksum(file)
    let f = substitute(system('sha256sum -b ' . a:file . '|cut -d" " -f1'), "\n*$", '', '')
    put =f
endfunction
command -nargs=1 -complete=file GetChecksum call GetChecksum(<q-args>)

function! GetHash()
    call search("sha256")
    normal d)
    let f = substitute(system('makepkg -g 2> /dev/null'), "\n*$", '', '')
    put =f
endfunction
command GetHash call GetHash()
