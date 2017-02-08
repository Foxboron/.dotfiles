call plug#begin('~/.vim/bundle')
" 1. Plugins
"   Vim-plug - Plugin manager
    Plug 'junegunn/vim-plug'

"   Vim-Go - for go stuff
    Plug 'fatih/vim-go', {'for': 'go'}

"   Vim-Wiki - For notes and stuff
    Plug 'vimwiki/vimwiki'

"   Syntastic - Dem syntax errors yo
    Plug 'scrooloose/syntastic'

"   Because its great
    Plug 'tpope/vim-fugitive'

"   Commenting
    Plug 'tpope/vim-commentary'

"   Latex sanity
    Plug 'lervag/vimtex'

"   Keeping sessions
    Plug 'tpope/vim-obsession'

"   Trying out snippets
    Plug 'sirver/ultisnips'
    Plug 'honza/vim-snippets'
    " We dont really want expand trigger over tab.
    " CBA to add a shitton of vimscript for tab completion
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"
    let g:UltiSnipsListSnippets="<c-l>"

"   Lets try completion
    Plug 'Shougo/neocomplete.vim'
    let g:acp_enableAtStartup = 0
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#sources#syntax#min_keyword_length = 1



call plug#end()

" 2. Hotkeys
"   2.1 Leader Hotkeys (SPACE)
"       r: ctags regen
"       s: search ctags
"       f: find
"       g: grep
"       t: find tag 
"       d: Git diff 
"       e: open quickfix
"       l: open location list
"       w: close buffer 
"       j: prev buffer 
"       k: next buffer 
"       <Tab>: Cycle tabs
"       /: Open last text match innside a quickfix window 
"   2.2 Maps
"      2.1 - Normal
"           ^A: start of line
"           ^E: end of line
"           ^Q: Paranthesis match
"           ESC: Disable hlsearch
"           ^J: rebound }
"           ^K: rebound {
"           ^P: Location/Quickfix previous
"           ^N: Location/Quickfix next 
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
"           ^X^O: Omnicomplete
"           ^N: Anything from complete
"       2.4 VimWiki



" =========
" Theme
" =========
set termguicolors
set t_Co=256
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
set t_ut=
syntax enable
filetype plugin indent on
colorscheme gotham

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

set wrap
set wrapmargin=80
set textwidth=120
"History and undo
set history=1000
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000
" Completion menu
set completeopt=longest,menuone

"Wildmenu
set path=.                  " Include relative directory to the file
set path+=,,                " Include current directory
set path+=**                " Include recurisve directories
set wildmenu            	" visual autocomplete for command menu
set wildignorecase      " Make wildmenu ignore our case
set wildmode=longest,full	" Show vim completion menu

" File ignores for wildmenu
set wildignore+=.git
set wildignore+=*.pyc
set wildignore+=node_modules
set wildignore+=.tags

"cTags
set tags=./.tags;$HOME

" =========
" Searching
" =========
set ignorecase
set smartcase
set incsearch


" ===========
" Indentation
" ===========
set smartindent " Clever indentation
set autoindent 	" Indent automatically
set expandtab " We want spaces!
set tabstop=4
set softtabstop=4
set shiftwidth=4




" ======
" Remaps - Default things in vim i have remapped or improved
" ======

"FUCK YOU HASH KEY
inoremap # X<BS>#

" Dont move on *
nnoremap * *<c-o>

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

"Faster up and down
noremap <C-J> }
noremap <C-K> {
vnoremap <C-J> }
vnoremap <C-K> {



" ===============
" Leader Mappings
" ===============
let mapleader=" "
let maplocalleader=" "

" Toggle hlsearch
"map <silent><leader>s :source ~/.vimrc<CR>
map <leader>r :!ctags -f .tags -R .<CR>
map <leader>f :find 
map <leader>g :Ag 
map <leader>s :ltag /
map <leader>e :call ToggleList("Location List", 'l')<CR>
map <leader>d :tabedit %<cr>:Gdiff<cr>
map <leader>m :make<cr>

" ========
" New Maps
" ========
map <silent><ESC> :set hlsearch!<CR>
noremap <silent><C-S> :silent update<CR>
nnoremap <leader><TAB> :tabnext<CR>

" Ref: toggle.vim
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>
nnoremap <silent><C-n> :execute windowNext<cr>zvzz
nnoremap <silent><C-p> :execute windowPrev<cr>zvzz

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
nnoremap <leader>j  :bnext<CR>
nnoremap <leader>k  :bprev<CR>
nnoremap <leader>c  :bd<CR>
nnoremap <leader>bn  :enew<CR>

" =================
" Command line maps
" =================
cnoremap <C-K> <Up>
cnoremap <C-J> <Down>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cmap W w !sudo tee % >/dev/null

" This monster lets us use star with a visual selection
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>


set grepformat^=%f:%l:%c:%m
if executable('ag')
    " Use the ignore list from wildignore
    let ignore_string=""
    let strings = split(&wildignore,",")
    for i in strings
        let ignore_string .= " --ignore '".i."'"
    endfor
    let &grepprg="ag --vimgrep --hidden ".ignore_string
    command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!|call SetListMaps('c')
endif
au FilterWritePre * if &diff | source ~/.vim/after/script/diff.vim

command! Source :source ~/.vimrc

