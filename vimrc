set t_Co=256
set noshowmode
set laststatus=2
execute pathogen#infect()
syntax enable
set background=dark


map nn :NERDTreeToggle<CR>

let g:rehash256 = 1
"let g:solarized_termcolors=16
let g:solarized_termcolors=256
colorscheme solarized
filetype plugin indent on



nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
