" I'm lazy
function! GetChecksum(file)
    let f = substitute(system('sha256sum -b ' . a:file . '|cut -d" " -f1'), "\n*$", '', '')
    put =f
endfunction
command -nargs=1 -complete=file GetChecksum call GetChecksum(<q-args>)
