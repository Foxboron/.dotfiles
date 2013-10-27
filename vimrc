let $PYTHONPATH="/usr/lib/python3.3/site-packages"

set mouse=a
set t_Co=256
set noshowmode
set laststatus=2
execute pathogen#infect()
syntax enable

map nn :NERDTreeToggle<CR>

" IMPORTANT: Uncomment one of the following lines to force
" " using 256 colors (or 88 colors) if your terminal supports it,
" " but does not automatically use 256 colors by default.
" "set t_Co=256
" "set t_Co=88
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

let g:pymode_folding = 0 
let g:solarized_termcolors=256
colorscheme solarized
filetype plugin indent on
set background=dark

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
