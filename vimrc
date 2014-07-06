execute pathogen#infect()
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {'build' : {'unix': 'make'}}
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'emezeske/paredit.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'klen/python-mode'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tpope/vim-fireplace'
NeoBundle 'tpope/vim-classpath'
NeoBundle 'guns/vim-clojure-static'

NeoBundleCheck

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
let g:airline_theme="solarized"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_detect_whitespace = 0
let g:pymode_folding = 0 
let g:pymode_doc = 0
"let g:pymode_python='python3'
let g:pymode_virtualenv = 1
let g:solarized_termcolors=16
let g:unite_source_rec_max_cache_files = 999999
let g:jekyll_path = "~/blog"
let g:instant_markdown_autostart = 0



highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/


map <Leader>jn  :JekyllPost<CR>

map <Leader>mp :InstantMarkdownPreview<CR>

map <Leader>gc :Gcommit -a<CR>
"map <Leader>gw :Gwrite <CR>
map <Leader>gp :Git push<CR>
map <Leader>gs :Gstatus<CR>
map <Leader>gq :Gwq<CR>


nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


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

inoremap <C-A> <Home>
inoremap <C-E> <End>


"Unite
let g:unite_update_time = 1
let g:unite_prompt='» '
let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
let g:unite_source_grep_recursive_opt = ''

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file,file/new,buffer,file_rec',
                            \ 'matchers', 'matcher_fuzzy')
"call unite#custom#source('grep', 'ignore_pattern', '\.*$')
"call unite#custom#source('file_rec/async', 'ignore_pattern', '\.*')

nnoremap <leader>b :<C-u>Unite -start-insert file<cr>
nnoremap <leader>f :<C-u>Unite -start-insert file_rec/async:.<cr>
nnoremap <leader>dc :<C-u>Unite -start-insert file_rec/async:~/Dropbox/Clojure<cr>
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


au BufWritePost ~/.vimrc :source ~/.vimrc | AirlineRefresh
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
