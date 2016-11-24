" ==========
" Statusline 
" ==========

let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'N·Operator Pending',
    \ 'v'  : 'VISUAL',
    \ 'V'  : 'V·Line',
    \ '^V' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'R',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'}

function! GitInfo()
  let git = system('git rev-parse --abbrev-ref HEAD 2>/dev/null')
  if git != ''
    return '  '.substitute(git, "\n*$", '', '').''
  else
    return ''
endfunction

set statusline=
set statusline+=[%n]
set statusline+=\[%{toupper(g:currentmode[mode()])}]
set statusline+=\%{GitInfo()}\  
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%y
set statusline+=[%l/%P]

" Start at same location
au BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"" |
	\ endif
