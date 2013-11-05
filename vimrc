execute pathogen#infect()
colorscheme solarized
syntax enable
filetype plugin indent on

let mapleader=","

set mouse=a
set number
"set t_Co=256
set background=dark
set so=50
set noshowmode
set laststatus=2
set clipboard=unnamed
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar


let g:airline_theme="solarized"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_detect_whitespace = 0
let g:pymode_folding = 0 
let g:solarized_termcolors=16


map nn :NERDTreeToggle<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

imap ii <Esc>

"Unite
let g:unite_prompt='» '
nnoremap <leader>f :<C-u>Unite -start-insert file_rec/async<cr>
nnoremap <leader>ug :<C-u>Unite grep:.<cr>
nnoremap <leader>s :<C-u>Unite -quick-match buffer<cr>


au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
