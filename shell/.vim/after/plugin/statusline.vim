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

" Colors

"call s:Col('StatusLineNC', 'base4', 'base2')
hi User0 ctermbg=11     ctermfg=10   guibg=green guifg=red

hi User1 ctermbg=15     ctermfg=11   guibg=#d3ebe9 guifg=#245361
hi User2 ctermbg=14     ctermfg=10   guibg=#599cab guifg=#091f2e
hi User3 ctermbg=11     ctermfg=8    guibg=#245461 guifg=#11151c

hi User4 ctermbg=20     ctermfg=11   guibg=#245361 guifg=#d3ebe9
hi User4NC ctermbg=20     ctermfg=11   guibg=red guifg=blue
hi User5 ctermbg=14     ctermfg=10   guibg=#091f2e guifg=#599cab
hi User6 ctermbg=11     ctermfg=8    guibg=#11151c guifg=#245461



set statusline=
"set statusline+=%4*
set statusline+=[%n]
set statusline+=\[%{toupper(g:currentmode[mode()])}]
"set statusline+=\%{GitInfo()}\  
set statusline+=%6*
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%y
set statusline+=[(%l/%c)/%p]

" Start at same location
au BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"" |
	\ endif
