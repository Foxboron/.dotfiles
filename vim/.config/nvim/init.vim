let VimPlugDir=expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(VimPlugDir)
    echo "Installing vim-plug.."
    echo ""

    if !isdirectory(expand("~/.config/nvim/.trash"))
        silent !mkdir -p ~/.config/nvim/.trash/undo
        silent !mkdir -p ~/.config/nvim/.trash/swap
        silent !mkdir -p ~/.config/nvim/.trash/backup
    endif

    silent !mkdir -p ~/.config/nvim/autoload
    silent !mkdir -p ~/.config/nvim/bundle
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    auto VimEnter * PlugInstall
endif

if !has('nvim')
    au VimEnter * silent! !dynamic-colors switch gotham
    au VimLeave * silent! !dynamic-colors switch default
end

set rtp+=$HOME/.config/nvim/autoload/plug.vim


call plug#begin('~/.config/nvim/bundle')
Plug 'junegunn/vim-plug'

"Look and feel
Plug 'bling/vim-airline'
Plug 'mhinz/vim-startify'
Plug 'whatyouhide/vim-gotham'
Plug 'zhaocai/GoldenView.Vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"Language specefic
Plug 'klen/python-mode', {'for' : 'python'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'ternjs/tern_for_vim', {'for': 'javascript'}
Plug 'tpope/vim-fireplace', {'for' : ['clojure', 'hy']}
Plug 'guns/vim-clojure-static', {'for' : 'clojure'}
Plug 'hylang/vim-hy', {'for' : 'hy'}
Plug 'kovisoft/paredit', {'for' : ['clojure', 'hy']}
Plug 'junegunn/rainbow_parentheses.vim'

"Git
Plug 'jaxbot/github-issues.vim'
Plug 'tpope/vim-fugitive'

"Misc code editing
Plug 'scrooloose/syntastic'
Plug 'Raimondi/YAIFA'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

"Misc document editing
Plug 'tpope/vim-markdown', {'for' : 'markdown'}
Plug 'jtratner/vim-flavored-markdown', {'for' : 'markdown'}
Plug 'lervag/vimtex'
Plug 'junegunn/vim-journal'
Plug 'junegunn/goyo.vim'
Plug 'irrationalistic/vim-tasks'

Plug 'goldfeld/vim-seek'
Plug 'haya14busa/incsearch.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'chrisbra/SudoEdit.vim'
Plug 'jiangmiao/auto-pairs'

call plug#end()


syntax enable
filetype plugin indent on

let mapleader=" "
let maplocalleader=" "

set tags=./tags;$HOME

set t_Co=256
colorscheme gotham
set bg=dark
set ff=unix

set nocompatible
set mouse=a
set number
set so=10
set noshowmode
set wildmenu
set lazyredraw
set laststatus=2
set clipboard=unnamed
set hidden
set ttimeoutlen=50

" No more annoying files!
set backupdir=~/.config/nvim/.trash/backup/
set directory=~/.config/nvim/.trash/swap/
set undofile
set undodir=~/.config/nvim/.trash/undo/


set sessionoptions=blank,buffers,folds,curdir,globals,resize,winpos

"Fix line breaks
set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0

set cursorline

set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start
set autoindent
set ignorecase
set smartcase
set completeopt=menu
set hlsearch
set shell=/bin/zsh
set splitright


" Cursor
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Search and Replace binding
map /  <Plug>(incsearch-forward)
" nnoremap <silent> <Tab> :<C-u>nohlsearch<CR>
" nnoremap <silent> <C-j><C-j> :<C-u>nohlsearch<CR>
nnoremap <silent> <Esc> :<C-u>nohlsearch<CR>
nnoremap <expr>  <leader>m  ':%s///g<left><left>'
vnoremap <expr>  m  ':s///g<left><left>'
"vnoremap / <Esc>/\%V
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

"Macro stuff
nnoremap <Space>q @
vnoremap <Space> :'<,'>normal @q<cr>

nnoremap <leader>m :silent make\|redraw!\|cc<CR>

vnoremap y myy`y
vnoremap Y myY`y

map ø :
map ; :

map <Leader>jn  :JekyllPost<CR>
map <Leader>mp :InstantMarkdownPreview<CR>
map <leader>w :e ~/.notes.org<CR>

" Git
map <Leader>ga :Git add<CR>
map <Leader>gc :Gcommit -a<CR>
map <Leader>gw :Gwrite <CR>
map <Leader>gp :Gpush<CR>
map <Leader>gf :Gpull<CR>
map <Leader>gg :Gstatus<CR>
map <Leader>gq :Gwq<CR>


" map <leader>nh G2o<Esc>i*

" Emacs anyone?
noremap <C-A> ^
noremap <C-E> $
noremap <C-Q> %
noremap <silent><C-S> :silent update<CR>
inoremap <silent><C-S> <C-O>:silent update<CR>
nnoremap <leader>e :edit<Space>

" Muh splits
nnoremap <C-l> <Nop>
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <C-c> <C-W>c
nnoremap <C-W>v :vsplit<CR>
nnoremap <C-W>s :split<CR>
nnoremap <silent> <C-W><C-Q> :wqa<cr>


" Complete mode shortcuts
inoremap <C-l> <C-x><C-l>
inoremap <C-f> <C-x><C-f>
inoremap <C-]> <C-x><C-]>
inoremap <C-d> <C-x><C-d>


" More natrual movement
noremap j gj
noremap k gk
nnoremap gj 5j
nnoremap gk 5k


" Reverse maps
noremap ' `
noremap ` '


vnoremap . :norm.<CR>

"Reflow paragraph
nmap <leader>rf vapgq

" Use GoldenView to have file focus
nnoremap <silent> <C-f> :SwitchGoldenViewMain<CR>


" Tab movements
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabprev<CR>
nnoremap tk  :tabnext<CR>
nnoremap tl  :tablast<CR>
nnoremap tm  :tabm<Space>
nnoremap tn  :tabnew<CR>
nmap tf :tab sb<CR>
nmap tc :tabclose<CR>

" and buffers
nnoremap bj  :bnext<CR>
nnoremap bk  :bprev<CR>
nnoremap bn  :enew<CR>


" Neovim terminal commands
tnoremap <leader><Tab> <C-\><C-n>
nnoremap ttn :tabnew<CR>:terminal<CR>
cnoremap <C-K> <Up>
cnoremap <C-J> <Down>




" Plugins
let g:netrw_liststyle=3
let g:netrw_banner=0


" Startify
let g:startify_session_dir = "~/.sessions"
let g:startify_custom_header =
      \ map(split(system('fortune hackers | cowsay -f tux'), '\n'), '"   ". v:val') + ['']

let g:startify_list_order = [
        \ ['   Sessions:'],
        \ 'sessions',
        \ ['   Bookmarks:'],
        \ 'bookmarks',
        \ ['   Most recently used files:'],
        \ 'files',
        \ ['   Most recently used files in the current directory:'],
        \ 'dir',
        \ ]

let g:startify_bookmarks = [ 
        \ {'f': '~/.config/nvim/init.vim'}, 
        \ {'g': '~/.zshrc'},
        \ {'h': '~/.config/i3/config'}
        \]

let g:startify_files_number = 5
let g:startify_change_to_vcs_root = 0
let g:startify_session_persistence = 1

let g:airline_theme="gotham256"
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 1
let g:instant_markdown_autostart = 0

let g:goldenview__enable_default_mapping = 0

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_javascript_checkers = ['gjslint']


"YouCompleteMe
set omnifunc=syntaxcomplete#Complete
let g:ycm_key_list_select_completion = ['<C-n>']
let g:ycm_key_list_previous_completion = ['<C-p>']
let g:ycm_python_binary_path = '/usr/bin/python3'

" zfz.vim
nnoremap <silent><leader>f :Files <cr>
nnoremap <silent><leader>gf :GFiles <cr>
nnoremap <silent><leader>ug :Ag 
nnoremap <silent> <Leader>uw :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>cc :Tags <C-R><C-W><CR>
nnoremap <silent> <Leader>cb :BTags <C-R><C-W><CR>
vnoremap <leader>us :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy:Ag <C-R><C-R>=substitute(
  \escape(@", '/*$^~['), '\n', '', 'g')<CR><CR>

function! s:fzf_statusline()
  setlocal laststatus=2
  setlocal statusline=fzf
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()


if !&diff 
    au VimEnter * EnableGoldenViewAutoResize 
else 
    au VimResized * exe "normal \<c-w>="
    au VimEnter * set ea
endif

au InsertEnter * set nornu
au InsertLeave * set rnu
highlight OverLength ctermbg=blue ctermfg=white guibg=#592929
match OverLength /\%81v./

au VimEnter * RainbowParentheses

au BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif

function! s:goyo_enter()
    au!
    autocmd InsertEnter * :set nonumber
    autocmd InsertLeave * :set norelativenumber
    au VimResized * exe "normal \<c-w>="
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()

function! s:goyo_leave()
    au!
    au InsertEnter * set nornu
    au InsertLeave * set rnu
endfunction
autocmd! User GoyoLeave nested call <SID>goyo_leave()

au TermOpen * setlocal listchars=


au FocusLost * silent! wa

au FilterWritePre * if &diff | exe 'nnoremap <C-p> [c' | exe 'nnoremap <C-n> ]c' | endif
command! GdiffInTab tabedit %|Gdiff


"silent! so .tmp.vim.snip
" Source files
for sourcefile in split(globpath(expand('~/.config/nvim/config'), '*.vim'), '\n')
    if filereadable(sourcefile)
        exe 'source' sourcefile
    else
        echo "Warning: " sourcefile " is unreadable"
    endif
endfor
