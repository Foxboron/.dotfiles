

let IWantPlug=1
let VimPlugDir=expand('~/.vim/autoload/plug.vim')
if !filereadable(VimPlugDir)
    echo "Installing vim-plug.."
    echo ""

    if !isdirectory(expand("~/.vim/.trash"))
        mkdir(expand('~/.vim/.trash'))
    endif

    silent !mkdir -p ~/.vim/autoload
    silent !mkdir -p ~/.vim/bundle
    silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let IWantPlug=0
endif


set rtp+=$HOME/.vim/autoload/plug.vim


call plug#begin('~/.vim/bundle')
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


set t_Co=256
colorscheme gotham
set bg=dark

set enc=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set encoding=utf-8

syntax enable
filetype plugin indent on

let mapleader=" "
let maplocalleader=","
set nocompatible
set mouse=a
set number
set so=50
set noshowmode
set wildmenu
set lazyredraw
set laststatus=2
set clipboard=unnamed
set hidden
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set ttimeoutlen=50

" No more annoying files!
set backupdir=~/.vim/.trash/backup/
set directory=~/.vim/.trash/swap/
set undodir=~/.vim/.trash/undo/

"Fix line breaks
set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0

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

let g:airline_theme="gotham256"
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 1
"let g:airline_exclude_preview = 1
let g:instant_markdown_autostart = 0
let g:goldenview__enable_default_mapping = 0
let g:org_indent = 0

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

" Plugin key-mappings.
" inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()


map /  <Plug>(incsearch-forward)
nnoremap <silent> q :<C-u>nohlsearch<CR>

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


" Emacs anyone?
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <C-A> <Home>
noremap <C-E> <End>
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
nnoremap td  :tabclose<CR>
nnoremap bj  :bnext<CR>
nnoremap bk  :bprev<CR>

" How do i even vim?
noremap <C-S> :update<CR>
inoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
nnoremap <leader>e :edit<Space>
inoremap <C-J><C-J> <ESC>

nnoremap <C-W>v :vsplit<CR>
nnoremap <C-W>s :split<CR>

nnoremap <silent> <C-f> :SwitchGoldenViewMain<CR>

"Unite
let g:unite_update_time = 1
let g:unite_source_rec_max_cache_files=5000
let g:unite_prompt='» '
let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --ignore-dir={".*/",__pycache__,node_modules} --hidden -g ""'
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
let g:unite_source_grep_recursive_opt = ''

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_rec/async', 'ignore_pattern', 'node_modules/\|bower_components/')
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


highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

au VimEnter * RainbowParentheses

if !has('nvim')
    au VimEnter * silent! !dynamic-colors switch gotham
    au VimLeave * silent! !dynamic-colors switch default
end

au InsertEnter * set nornu
au InsertLeave * set rnu
au FocusLost * silent! wa
au FilterWritePre * if &diff | exe 'nnoremap <C-p> [c' | exe 'nnoremap <C-n> ]c' | endif
au FilterWritePre * if &diff | exe 'nnoremap <C-p> [c' | exe 'nnoremap <C-n> ]c' | endif

augroup filetype_gitcommit
    autocmd!
    au BufEnter */COMMIT_EDITMSG nnoremap <silent> <C-W><C-Q> :update<cr>:exec "wincmd q"<cr>:exec "Gstatus"<cr>
augroup END

au BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif

"silent! so .tmp.vim.snip

for sourcefile in split(globpath(expand('~/.vim/config'), '*.vim'), '\n')
    if filereadable(sourcefile)
        exe 'source' sourcefile
    else
        echo "Warning: " sourcefile " is unreadable"
    endif
endfor
