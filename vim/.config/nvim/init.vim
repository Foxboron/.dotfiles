call plug#begin('~/.config/nvim/bundle')
" 1. Plugins
"   Vim-plug - Plugin manager
    Plug 'junegunn/vim-plug'
"   Vim-Go - for go stuff
    Plug 'fatih/vim-go', {'for': 'go'}
"   Vim-Wiki - For notes and stuff
    Plug 'vimwiki/vimwiki'
"   Syntastic - Dem syntax errors yo
    Plug 'scrooloose/syntastic'


call plug#end()

" 2. Hotkeys
"   2.1 Leader Hotkeys (SPACE)
"       s: source vimrc
"       r: ctags regen
"       f: find
"       g: grep
"       e: open quickfix
"       l: open location list
"   2.2 Maps
"      2.1 - Normal
"           ^A: start of line
"           ^E: end of line
"           ^Q: Paranthesis match
"           ESC: Disable hlsearch
"      2.2 - Insert
"           ^S: save file
"      2.3 - Visual
"           *: Visual hlsearch 
"      2.4 - Command Line 
"           ^J: Down in history
"           ^K: Up in history
"           ^A: start of line
"           ^E: end of line
"      2.5 - Terminal
"       
"   2.3 Nice To Know 
"       2.4 ins-complete 
"           ^X^N: Just this file
"           ^X^F: For filenames
"           ^X^]: From ctags only 
"           ^N: Anything from complete
"       2.4 VimWiki



" =========
" Theme
" =========
syntax enable
filetype plugin indent on
set t_Co=256
colorscheme gotham
set bg=dark

" Sane defaults
set ff=unix
set nocompatible
set shell=/bin/zsh


" =========
" Visual 
" =========
set number
set ruler
set cursorline
set noshowmode
set laststatus=2    " always show statusbar  
set ttimeoutlen=50
set shortmess+=I    "We dont care for the intro message


" =========
" Behaviour
" =========
set nobackup            " lol
set noswapfile          " Yolo
set magic               " Muh regex
set mouse=a             " We don't want the mouse
set clipboard=unnamed   " We want to access clipboard from X
set scrolloff=10 	    " 10 lines space between frame and cursor
set splitright          " Splitting right feels more natrual
set ttyfast
set diffopt+=vertical
set hidden              " So we can create new buffers and dont need to save them
set noesckeys           " Remap esc!

" Completion menu
set completeopt=longest,menuone

"Wildmenu
set path=.                  " Include relative directory to the file
set path+=,,                " Include current directory
set path+=**                " Include recurisve directories
set wildmenu            	" visual autocomplete for command menu
set wildignorecase      " Make wildmenu ignore our case
set wildmode=longest,full	" Show vim completion menu

" File ignores
set wildignore+=.git
set wildignore+=*.pyc
set wildignore+=node_modules
set wildignore+=tags

"cTags
set tags=./.tags;$HOME

" =========
" Searching
" =========
set ignorecase
set smartcase
set incsearch


" =========
" Indentation
" =========
set smartindent " Clever indentation
set autoindent 	" Indent automatically
set expandtab " We want spaces!
set tabstop=4
set softtabstop=4
set shiftwidth=4



" =========
" Nvim defaults 
" =========
if has('nvim')
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[2 q"
end


" ======
" Remaps - Default things in vim i have remapped
" ======

map ø :
map ; :

" More natural movement when lines wrap
noremap j gj
noremap k gk
nnoremap gj 5j
nnoremap gk 5k

" Emacs stuff i really like
noremap <C-A> ^
noremap <C-E> $
noremap <C-Q> %


" ===============
" Leader Mappings
" ===============
let mapleader=" "
let maplocalleader=" "

" Toggle hlsearch
map <silent><leader>s :source ~/.config/nvim/init.vim<CR>
map <leader>r :!ctags -f .tags -R .
map <leader>f :find 
map <leader>g :grep! 


" ========
" New Maps
" ========
map <ESC> :set hlsearch!<CR>
noremap <silent><C-S> :silent update<CR>
inoremap <silent><C-S> <C-O>:silent update<CR>


" Tabs
nnoremap <leader>th  :tabfirst<CR>
nnoremap <leader>tj  :tabprev<CR>
nnoremap <leader>tk  :tabnext<CR>
nnoremap <leader>tl  :tablast<CR>
nnoremap <leader>tm  :tabm<Space>
nnoremap <leader>tn  :tabnew<CR>
nmap <leader>tf :tab sb<CR>
nmap <leader>tc :tabclose<CR>

" Buffers
nnoremap <leader>bj  :bnext<CR>
nnoremap <leader>bk  :bprev<CR>
nnoremap <leader>bn  :enew<CR>

" Command line maps
cnoremap <C-K> <Up>
cnoremap <C-J> <Down>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" This monster lets us use star with a visual selection
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>


set grepformat^=%f:%l:%c:%m
if executable('ag')
    set grepprg=ag\ --vimgrep\ --hidden\ --ignore\ \'.git\'
endif
