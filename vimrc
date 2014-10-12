let IWantPlug=1
let VimPlugDir=expand('~/.vim/autoload/plug.vim')
if !filereadable(VimPlugDir)
    echo "Installing vim-plug.."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !mkdir -p ~/.vim/bundle
    silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let IWantPlug=0
endif


set rtp+=$HOME/.vim/autoload/plug.vim


call plug#begin('~/.vim/bundle')

Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'ervandew/supertab'
Plug 'emezeske/paredit.vim', {'for' : ['clojure', 'hy']}
Plug 'godlygeek/csapprox'
Plug 'goldfeld/vim-seek'
Plug 'guns/vim-clojure-static', {'for' : 'clojure'}
Plug 'hylang/vim-hy', {'for' : 'hy'}
Plug 'junegunn/vim-plug'
Plug 'KevinGoodsell/vim-csexact'
Plug 'kien/rainbow_parentheses.vim'
Plug 'klen/python-mode', {'for' : 'python'}
Plug 'Lokaltog/vim-easymotion'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-classpath', {'for' : 'clojure'}
Plug 'tpope/vim-fireplace', {'for' : 'clojure'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown', {'for' : 'markdown'}
Plug 'tpope/vim-surround'
Plug 'whatyouhide/vim-gotham'
Plug 'wting/rust.vim', {'for' : 'rust'}

call plug#end()

if IWantPlug == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :PlugUpdate
endif


set t_Co=256
colorscheme gotham 
set bg=dark

syntax enable
filetype plugin indent on

let mapleader=","
set mouse=a
set number
set so=50
set noshowmode
set wildmenu
set lazyredraw
set laststatus=2
set clipboard=unnamed
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=e
set guioptions-=L
set guioptions-=l
set guioptions-=R
set guioptions-=b
set guioptions-=h
set guiheadroom=0
set ttimeoutlen=50

" No more annoying files!
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

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
set autochdir

let g:airline_theme="gotham256"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_detect_whitespace = 0
let g:pymode_folding = 0 
let g:pymode_doc = 0
let g:pymode_virtualenv = 1
let g:instant_markdown_autostart = 0



map <Leader>jn  :JekyllPost<CR>
map <Leader>mp :InstantMarkdownPreview<CR>


" Git
map <Leader>gc :Gcommit -a<CR>
map <Leader>gw :Gwrite <CR>
map <Leader>gp :Git push<CR>
map <Leader>gs :Gstatus<CR>
map <Leader>gq :Gwq<CR>


" Emacs anyone?
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap <C-A> <Home>
inoremap <C-E> <End>
nnoremap <C-A> <Home>
nnoremap <C-E> <End>

"Easymotion keybinds
map ø <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
map <Space>l <Plug>(easymotion-lineforward)
map <Space>j <Plug>(easymotion-j)
map <Space>k <Plug>(easymotion-k)
map <Space>h <Plug>(easymotion-linebackward)
nmap s <Plug>(easymotion-s2)
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
let g:EasyMotion_smartcase = 1


" Tab movements
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

" How do i even vim?
noremap <C-Q> :wq<CR>
inoremap <C-Q> <C-O>:wq<CR>
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
nnoremap <leader>e :edit<Space>
inoremap <C-J><C-J> <ESC>


"Unite
let g:unite_update_time = 1
let g:unite_source_rec_max_cache_files = 999999
let g:unite_prompt='» '
let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
let g:unite_source_grep_recursive_opt = ''

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file,file/new,buffer,file_rec',
                            \ 'matchers', 'matcher_fuzzy')

nnoremap <leader>b :<C-u>Unite -start-insert file<cr>
nnoremap <leader>f :<C-u>Unite -start-insert file_rec/async<cr>
nnoremap <leader>ug :<C-u>Unite -start-insert grep:.<cr>
nnoremap <leader>s :<C-u>Unite -quick-match buffer<cr>

autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-s>   <Plug>(unite_redraw)
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction



highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

au BufWritePost ~/.vimrc :source ~/.vimrc | CSExactColors 
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


" Markdown
au FileType markdown set tabstop=2
au FileType markdown set softtabstop=2
au FileType markdown set shiftwidth=2
