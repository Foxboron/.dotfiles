let IWantPlug=1
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
    let IWantPlug=0
endif

if !has('nvim')
    au VimEnter * silent! !dynamic-colors switch gotham
    au VimLeave * silent! !dynamic-colors switch default
end

set rtp+=$HOME/.config/nvim/autoload/plug.vim


call plug#begin('~/.config/nvim/bundle')
Plug 'bling/vim-airline'
Plug 'kovisoft/paredit', {'for' : ['clojure', 'hy']}
Plug 'goldfeld/vim-seek'
Plug 'guns/vim-clojure-static', {'for' : 'clojure'}
Plug 'hylang/vim-hy', {'for' : 'hy'}
Plug 'junegunn/vim-plug'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'klen/python-mode', {'for' : 'python'}
Plug 'haya14busa/incsearch.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Shougo/unite.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fireplace', {'for' : ['clojure', 'hy']}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown', {'for' : 'markdown'}
Plug 'tpope/vim-surround'
Plug 'whatyouhide/vim-gotham'
Plug 'Raimondi/YAIFA'
Plug 'zhaocai/GoldenView.Vim'
Plug 'jceb/vim-orgmode', {'for': 'org'}
Plug 'scrooloose/syntastic'
Plug 'chrisbra/SudoEdit.vim'
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'jaxbot/github-issues.vim'
Plug 'ervandew/supertab'

call plug#end()

if IWantPlug == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :PlugUpdate
endif

syntax enable
filetype plugin indent on

let mapleader=" "
let maplocalleader=","

set t_Co=256
colorscheme gotham
set bg=dark

set enc=utf-8
set fileencoding=utf-8
set termencoding=utf-8

set nocompatible
set mouse=a
set number
set so=50
set noshowmode
set wildmenu
set lazyredraw
set laststatus=2
set clipboard=unnamedplus
set hidden
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set ttimeoutlen=50

" No more annoying files!
set backupdir=~/.config/nvim/.trash/backup/
set directory=~/.config/nvim/.trash/swap/
set undodir=~/.config/nvim/.trash/undo/

"Fix line breaks
set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0

set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set autoindent
set ignorecase
set smartcase
set completeopt=menu
set hlsearch
set shell=/bin/zsh


set splitbelow
set splitright


let g:netrw_liststyle=3


let g:airline_theme="gotham256"
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 1
let g:instant_markdown_autostart = 0
let g:org_indent = 0


let g:goldenview__enable_default_mapping = 0

let g:pymode_folding = 0
let g:pymode_doc = 0
let g:pymode_virtualenv = 1
let g:pymode_warnings = 0
let g:pymode_options_colorcolumn = 0
let g:pymode_lint_cwindow = 0
let g:syntastic_javascript_checkers = ['gjslint']

let g:neocomplete#enable_at_startup = 1
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'



map /  <Plug>(incsearch-forward)
nnoremap <silent> \| :<C-u>nohlsearch<CR>
nnoremap <Space>q @q<Esc><Esc>
vnoremap <Space> :'<,'>normal @q<cr>

map ø :

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


map <leader>nh G2o<Esc>i*



noremap j gj
noremap k gk
nnoremap gj 5j
nnoremap gk 5k


" Emacs anyone?
map <C-l> <Nop>
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <C-c> <C-W>c
noremap <C-A> ^
noremap <C-E> $
noremap <C-Q> %

cnoremap <C-K> <Up>
cnoremap <C-J> <Down>

" Tab movements
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tm  :tabm<Space>
nnoremap tn  :tabnew<CR>
nmap tf :tab sb<CR>
nmap tc :tabclose<CR>
nnoremap bj  :bnext<CR>
nnoremap bk  :bprev<CR>



" Neovim terminal commands
tnoremap <leader><Tab> <C-\><C-n>
nnoremap ttn :tabnew<CR>:terminal<CR>
map <C-t> :split<CR>:terminal<CR>

" How do i even vim?
noremap <C-S> :update<CR>
inoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
nnoremap <leader>e :edit<Space>
inoremap <C-J><C-J> <ESC>

nnoremap <C-W>v :vsplit<CR>
nnoremap <C-W>s :split<CR>
nnoremap <silent> <C-W><C-Q> :wqa<cr>

nnoremap <silent> <C-f> :SwitchGoldenViewMain<CR>



"Unite
let g:unite_update_time = 1
let g:unite_source_rec_max_cache_files=5000
let g:unite_prompt='» '
let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--vimgrep --nogroup --nocolor --column'
let g:unite_source_grep_recursive_opt = ''

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file,file/new,buffer,file_rec',
                            \ 'matchers', 'matcher_fuzzy')
nnoremap <leader>f :<C-u>Unite -start-insert file_rec/async<cr>
nnoremap <leader>ug :<C-u>Unite -start-insert grep:.<cr>

autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
  imap <buffer> <C-j>   <ESC>
  nmap <silent><buffer><expr> <C-v> unite#do_action('split')
  nmap <silent><buffer><expr> <C-s> unite#do_action('vsplit')
  nmap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction





highlight OverLength ctermbg=blue ctermfg=white guibg=#592929
match OverLength /\%81v./



au VimEnter * RainbowParentheses
if !&diff 
    au VimEnter * EnableGoldenViewAutoResize 
endif
au InsertEnter * set nornu
au InsertLeave * set rnu
au FocusLost * silent! wa
au FilterWritePre * if &diff | exe 'nnoremap <C-p> [c' | exe 'nnoremap <C-n> ]c' | endif


augroup filetype_gitcommit
    autocmd!
    au BufEnter */COMMIT_EDITMSG nnoremap <silent> <C-W><C-Q> :update<cr>:exec "wincmd q"<cr>:exec "Gstatus"<cr>
    au BufEnter */COMMIT_EDITMSG nnoremap <silent> <C-c> :update<cr>:exec "wincmd q"<cr>:exec "Gstatus"<cr>
augroup END

au BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif




"silent! so .tmp.vim.snip
" Source files
for sourcefile in split(globpath(expand('~/.config/nvim/config'), '*.vim'), '\n')
    if filereadable(sourcefile)
        exe 'source' sourcefile
    else
        echo "Warning: " sourcefile " is unreadable"
    endif
endfor
