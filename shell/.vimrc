" {{{1 Plugin
call plug#begin('~/.vim/bundle')
" 1. Plugins
"   Vim-plug - Plugin manager
    Plug 'junegunn/vim-plug'

"   Vim-Go - for go stuff
    Plug 'fatih/vim-go', {'for': 'go'}

"   Vim-Wiki - For notes and stuff
    Plug 'vimwiki/vimwiki', {'on' : 'VimwikiIndex', 'for': 'wiki' }
    Plug 'tbabej/taskwiki', {'on': 'VimwikiIndex', 'for': 'wiki'}

"   Syntastic - Dem syntax errors yo
    " Plug 'scrooloose/syntastic'
    Plug 'w0rp/ale'

" # GIT STUFF
"   Because its great
    Plug 'tpope/vim-fugitive'
" Lets see if this replaces fugitive
    Plug 'gregsexton/gitv', { 'on' : 'Gitv' }
    Plug 'airblade/vim-gitgutter'

"   Commenting
    Plug 'tpope/vim-commentary'

"   Latex sanity
    Plug 'lervag/vimtex', {'for': 'tex'}

    Plug '907th/vim-auto-save', { 'for': 'tex' }

"   Trying out snippets
    Plug 'sirver/ultisnips'
    Plug 'honza/vim-snippets'

" ctrlP is honestly just a nice package that doesnt need configs
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'whatyouhide/vim-gotham'
    Plug 'maralla/completor.vim' 

" vimpager
    Plug 'rkitover/vimpager'

" goyo for editing
    Plug 'junegunn/goyo.vim'

call plug#end()
" }}}1
" {{{1 Description

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
" }}}1
" {{{1 Base config

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
set relativenumber  " start with relative numbers
set ruler
set cursorline
set noshowmode
set laststatus=2    " always show statusbar  
set ttimeoutlen=50
set shortmess=Iat    "We dont care for the intro message


" =========
" Behaviour
" =========
set nobackup            " lol
set noswapfile          " Yolo
set magic               " Muh regex
set mouse=              " We don't want the mouse
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
if !isdirectory(&undodir)
  call mkdir(&undodir)
endif

set undolevels=1000
set undoreload=10000
" Completion menu
set completeopt=menuone

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

if &foldmethod ==# ''
  set foldmethod=syntax
endif
set foldlevel=0
set foldcolumn=0
set foldtext=TxtFoldText()

function! TxtFoldText()
  let level = repeat('-', min([v:foldlevel-1,3])) . '+'
  let title = substitute(getline(v:foldstart), '{\{3}\d\?\s*', '', '')
  let title = substitute(title, '^["#! ]\+', '', '')
  return printf('%-4s %-s', level, title)
endfunction

" }}}}2
" {{{1 Mapping

"{{{2 Remappings
"
"FUCK YOU HASH KEY
inoremap # X<BS>#

" Dont move on *
nnoremap * *<c-o>

inoremap <silent> <C-S> <C-O>:update<CR>
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

" Folds
nnoremap          zf zMzvzz
nnoremap          zz za
nnoremap <silent> zj :silent! normal! zc<cr>zjzvzz
nnoremap <silent> zk :silent! normal! zc<cr>zkzvzz[z"}}}
"{{{2 Leader mapping
let mapleader=" "
let maplocalleader=","

" Toggle hlsearch
"map <silent><leader>s :source ~/.vimrc<CR>
map <leader>r :!ctags -f .tags -R .<CR>
map <leader>f :CtrlP<CR>
map <leader>v :Gitv<cr>
map <leader>g :Ag 
map <leader>s :CtrlPTag<CR>
map <leader>e :call ToggleList("Location List", 'l')<CR>
map <leader>d :tabedit %<cr>:Gdiff<cr>
map <leader>m :make<cr>
map <leader>v :Gitv<cr>


" Buffers
nnoremap <leader>bj  :bnext<CR>
nnoremap <leader>bk  :bprev<CR>
nnoremap <leader>j  :bnext<CR>
nnoremap <TAB>  :bnext<CR>
nnoremap <leader>k  :bprev<CR>
nnoremap <leader>c  :bd<CR>
nnoremap <leader>bn  :enew<CR>

" Tabs
nnoremap <leader>th  :tabfirst<CR>
nnoremap <leader>tj  :tabprev<CR>
nnoremap <leader>tk  :tabnext<CR>
nnoremap <leader>tl  :tablast<CR>
nnoremap <leader>tm  :tabm<Space>
nnoremap <leader>tn  :tabnew<CR>
nmap <leader>tf :tab sb<CR>
nmap <leader>tc :tabclose<CR>
"}}}
"{{{2 New mappings
" ========
" New Maps
" ========
map <silent><ESC> :set hlsearch!<CR>
noremap <silent><C-S> :silent update<CR>
nnoremap <leader><TAB> :tabnext<CR>
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>

" This monster lets us use star with a visual selection
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Ref: toggle.vim
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>
nnoremap <silent><C-n> :execute windowNext<cr>zvzz
nnoremap <silent><C-p> :execute windowPrev<cr>zvzz

cnoremap <C-K> <Up>
cnoremap <C-J> <Down>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
"}}}
"{{{2 Commands
cmap W!! w !sudo tee % >/dev/null
command! Source :source ~/.vimrc
"}}}
" }}}2

"{{{1 Autocommand
augroup vimrc_autocommands
  autocmd!
  autocmd WinEnter,FocusGained  * setlocal cursorline
  autocmd WinLeave,FocusLost    * setlocal nocursorline
  " autocmd BufEnter              * setlocal number 
  autocmd InsertEnter           * setlocal norelativenumber
  autocmd InsertLeave           * setlocal relativenumber
  autocmd FilterWritePre        * if &diff | source ~/.vim/after/scripts/diff.vim
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line('$') |
        \   execute 'normal! g`"' |
        \ endif

augroup END

augroup vimwiki_template
function! InitTemplate()
    let f = system("date \"+%Y-%m-%d\" | tr -d '\n' | xargs -d '\n' -0 printf '= %s ='")
    let l = append(0, f)
    let f2 = system("cat ~/Notes/diary/$(date '+%Y-%m-%d' --date='yesterday').wiki | grep -E '^=.*=$' | tail -n+2 | xargs -d '\n' printf '%s\n\n'")
    put =f2
    normal gg
endfunction

    autocmd BufEnter    *   setlocal nowrap
    autocmd BufNewFile */diary/*.wiki call InitTemplate()
augroup END

" Because numbers can fuck off
function! s:goyo_enter()
    augroup goyo_enter
        autocmd BufEnter    *   setlocal tw=80
        autocmd InsertEnter *   setlocal nonumber
        autocmd InsertLeave *   setlocal norelativenumber
    augroup END
endfunction

function! s:goyo_leave()
  augroup goyo_enter
    autocmd!
  augroup END
  augroup! goyo_enter 
endfunction

autocmd User GoyoEnter nested call <SID>goyo_enter()
autocmd User GoyoLeave nested call <SID>goyo_leave()

"}}}1
" {{{1 Grep
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

" }}}2
"{{{1 Plugins
"{{{2 internal: matchit
packadd! matchit
"}}}
"{{{2 plugin: vimtex
let g:vimtex_compiler_callback_hooks = ['CleanFiles']
function! CleanFiles(status)
    call system('latexmk -c')
endfunction
"}}}
"{{{2 plugin: completor
let g:completor_gocode_binary = '/home/fox/.go/bin/gocode'
let g:completor_python_binary = '/usr/bin/python'
"}}}
"{{{2 plugin: airline
let g:airline_theme='gotham'
let g:airline_extensions = ['branch', 'tabline', 'ale', 'ctrlp']
"}}}
"{{{2 plugin: ctrlp
let g:ctrlp_map = '<leader>p'
"}}}
"{{{2 plugin: ultisnips
" We dont really want expand trigger over tab.
" CBA to add a shitton of vimscript for tab completion
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-l>"
"}}}
"{{{2 plugin: vim-go
let g:go_info_mode = 'guru'
noremap <localleader>l :GoLint<cr>
noremap <localleader>v :GoVet<cr>
noremap <localleader>b :GoBuild<cr>
noremap <localleader>i :GoInfo<cr>
noremap <localleader>r :GoRun<cr>
noremap <localleader>n :GoRename<cr>
"}}}
"{{{2 plugin: vimwiki
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_listsyms = '✗○◐●✓'
let g:vimwiki_folding = ''
let main_wiki = {}
let main_wiki.path = '~/Notes'
let main_wiki.path_html = '~/.cache/vimwiki/html'
let main_wiki.automatic_nested_syntaxes = 1
let main_wiki.list_margin = 0
let g:vimwiki_list = [main_wiki]
hi VimwikiBold term=bold cterm=bold gui=bold ctermfg=178 guifg=#dfaf00
hi VimwikiItalic term=italic cterm=italic gui=italic ctermfg=178 guifg=#dfaf00
"}}}
"{{{2 plugin: taskwiki
let g:taskwiki_disable_concealcursor = 'yes'
"}}}
"}}}
" vim: fdm=marker
