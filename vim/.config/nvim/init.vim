" 1. Plugins
"
" 2. Hotkeys
"   2.1 Leader Hotkeys (SPACE)
"       h: toggles hilight
"       s: source vimrc
"       r: ctags regen
"   2.2 Maps
"      2.1 - Normal
"           ^A: start of line
"           ^E: end of line
"           ^Q: Paranthesis match
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
"       2.4 VimWiki




" =========
" Theme
" =========
syntax enable
filetype plugin indent on
set t_Co=256
let base16colorspace=256
colorscheme gotham256
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
set shortmess=      "We dont care for the intro message




" =========
" Behaviour
" =========
set nobackup            " lol
set noswapfile          " Yolo
set autoread            " We want all the changes!
set magic               " Muh regex
set mouse=a             " We don't want the mouse
set clipboard=unnamed   " We want to access clipboard from X
set scrolloff=10 	    " 10 lines space between frame and cursor
set splitright          " Splitting right feels more natrual
set ttyfast
set diffopt+=vertical
set hidden              " So we can create new buffers and dont need to save them

" Completion menu
set completeopt=longest,menuone

"Wildmenu
set path=.                  " Include relative directory to the file
set path+=,,                " Include current directory
set path+=**                " Include recurisve directories
set wildmenu            	" visual autocomplete for command menu
set wildmode=longest,full	" Show vim completion menu

" File ignores
set wildignore+=.git
set wildignore+=*.pyc

"cTags
set tags=./tags;$HOME


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
map <silent><leader>h :set hlsearch!<CR>
map <silent><leader>s :source ~/.config/nvim/init.vim<CR>
map <leader>r :!ctags -R .
map <leader>f :find 


" ========
" New Maps
" ========
noremap <silent><C-S> :silent update<CR>
inoremap <silent><C-S> <C-O>:silent update<CR>


" ========
" New Maps
" ========


" Tabs
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabprev<CR>
nnoremap tk  :tabnext<CR>
nnoremap tl  :tablast<CR>
nnoremap tm  :tabm<Space>
nnoremap tn  :tabnew<CR>
nmap tf :tab sb<CR>
nmap tc :tabclose<CR>

" Buffers
nnoremap bj  :bnext<CR>
nnoremap bk  :bprev<CR>
nnoremap bn  :enew<CR>

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
set statusline+=%m
set statusline+=[%n]
set statusline+=\[%{toupper(g:currentmode[mode()])}]
set statusline+=\%{GitInfo()}\  
set statusline+=\ %f
set statusline+=%=
"set statusline+=%{SyntasticStatuslineFlag()}             " Syntastic errors
set statusline+=%y
set statusline+=[%l/%P]

" Start at same location
au BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"" |
	\ endif
