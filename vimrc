set t_Co=256
set noshowmode
set laststatus=2
execute pathogen#infect()
syntax enable
set background=dark


map nn :NERDTreeToggle<CR>


let g:solarized_termcolors=256
colorscheme solarized
filetype plugin indent on
