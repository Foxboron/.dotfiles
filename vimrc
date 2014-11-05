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

Plug 'bling/vim-airline'
Plug 'ervandew/supertab'
Plug 'kovisoft/paredit', {'for' : ['clojure', 'hy']}
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
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fireplace', {'for' : 'clojure'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown', {'for' : 'markdown'}
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'whatyouhide/vim-gotham'
Plug 'wting/rust.vim', {'for' : 'rust'}
Plug 'Raimondi/YAIFA'
Plug 'zhaocai/GoldenView.Vim'

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
set nocompatible
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

let g:airline_theme="gotham256"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_detect_whitespace = 0
let g:instant_markdown_autostart = 0
let g:tmux_session = "repl"
let g:goldenview__enable_default_mapping = 0


let g:pymode_folding = 0 
let g:pymode_doc = 0
let g:pymode_virtualenv = 1
let g:pymode_warnings = 0
let g:pymode_options_colorcolumn = 0
let g:pymode_lint_cwindow = 0

map <Leader>jn  :JekyllPost<CR>
map <Leader>mp :InstantMarkdownPreview<CR>


" Git
map <Leader>gc :Gcommit -a<CR>
map <Leader>gw :Gwrite <CR>
map <Leader>gp :Git push<CR>
map <Leader>gs :Gstatus<CR>
map <Leader>gq :Gwq<CR>


" Emacs anyone?
map <C-j> <C-W>j<C-W>_
map <C-j> <C-W>k<C-W>_
map <C-h> <C-W>h<C-W>_
map <C-l> <C-W>l<C-W>_
inoremap <C-A> <Home>
inoremap <C-E> <End>
nnoremap <C-A> <Home>
nnoremap <C-E> <End>

"Easymotion keybinds
map ø <Plug>(easymotion-sn)
map / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
map <Space>l <Plug>(easymotion-lineforward)
map <Space>j <Plug>(easymotion-j)
map <Space>k <Plug>(easymotion-k)
map <Space>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
let g:EasyMotion_smartcase = 1

nmap <CR> <Plug>(easymotion-repeat)



" Tab movements
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tm  :tabm<Space>
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

function! SwapWindowPos(win2)
    let win1 = winnr()
    let win2 = a:win2
    if win2 > 0 && win2 <= winnr('$') && win1 != win2
        let buf1 = bufnr('%')
        let line1 = line('.')
        let col1 = col('.')
        exe win2 . "wincmd w"
        let buf2 = bufnr("%")
        let line2 = line('.')
        let col2 = col('.')
        if buf1 != buf2
            exe 'buf' buf1
            exe win1 . "wincmd w"
            exe 'buf' buf2
            exe win2 . "wincmd w"
        else
            call cursor(line1, col1)
            redraw
            exe win1 . "wincmd w"
            call cursor(line2, col2)
            exe win2 . "wincmd w"
        endif
    endif
endfunction
nnoremap <silent> <leader>w :call SwapWindowPos(1)<CR>

"Unite
let g:unite_update_time = 1
let g:unite_source_rec_max_cache_files = 999999
let g:unite_prompt='» '
let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --ignore ".*/" --hidden -g ""'
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
  imap <buffer> <C-j>   <ESC>
  nmap <silent><buffer><expr> <C-v> unite#do_action('split')
  nmap <silent><buffer><expr> <C-s> unite#do_action('vsplit')
  nmap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction



function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>


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

au BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif

" Starts a repl using vim-proc
" Jacked some logic from leiningen-vim to autorun whenever a fireplace command
" is issued without a connection.
" If someone does see this and wonder WTF i'm doing, i got no idea.


fun! s:portfile() abort
    if getfsize('./.nrepl-port') > 0
        return './.nrepl-port'
    endif
endf

let g:repl_start=0
function! ReplFn() abort
    if g:repl_start == 0
        execute "call vimproc#popen2('lein repl')"
        let g:repl_start=1
    else
        return {}
    endif
    let i = 0
    let portfile = s:portfile()
    while empty(portfile) && i < 300 && !getchar(0)
        let i += 1
        sleep 100m
        let portfile = s:portfile()
    endwhile
    return empty(portfile) ? {} :
        \ fireplace#register_port_file(portfile, b:leiningen_root)
endfunction
command! Repl call ReplFn()

augroup leiningen
    autocmd!
    autocmd User FireplacePreConnect call ReplFn()
augroup END


