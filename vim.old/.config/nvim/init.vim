" 1. Plugins
"
" 2. Hotkeys
"       2.1 Leader Hotkeys (SPACE)
"		r:	Save and run Go program.
"		ev:	Open .vimrc in a split.
"		sv:	Reload vim with the new changes in .vimrc.
"		=:	Auto-indent the whole file.
"		n:	Jump to the next error (Syntastics).
"		E:	Close all syntastics error windows
"		p:	Jump to the previous error (Syntastics).
"		t:	Toggle the TagBar (Vim-Go).
"		g:	Run the Go linter on the project.
"		gg:	Doesnt work?
"		ii:	Run GoImplements on the current keyword under the cursor.
"		cc:	Run GoCallees on the current keyword under the cursor.
"		R:	Globaly rename the variable name.
"		q:	Quit vim.
"		qq:	Really quit vim.
"		h:	hide search highligt
"		
"	2.2 Other Hotkeys
"			
"	2.2.1 Nerdtree Hotkeys
"
"	2.2.2 VimWiki Hotkeys
"		<Leader>ww	Open default wiki index file.
"		<Leader>wt	Open default wiki index file in a new tab.
"		<Leader>ws	Select and open wiki index file.
"		<Leader>wd	Delete wiki file you are in.
"		<Leader>wr	Rename wiki file you are in.
"		<Enter>		Follow/Create wiki link
"		<Shift-Enter>	Split and follow/create wiki link
"		<Ctrl-Enter> 	Vertical split and follow/create wiki link
"		<Backspace>	Go back to parent(previous) wiki link
"		<Tab>		Find next wiki link
"		<Shift-Tab>	Find previous wiki link
"		For more keys, see :h vimwiki-mappings
"
"	2.3 Abbreviations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


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
Plug 'vimwiki/vimwiki'

"Language specefic
Plug 'klen/python-mode', {'for' : 'python'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'tpope/vim-fireplace', {'for' : ['clojure', 'hy']}
Plug 'guns/vim-clojure-static', {'for' : 'clojure'}
Plug 'hylang/vim-hy', {'for' : 'hy'}
Plug 'kovisoft/paredit', {'for' : ['clojure', 'hy']}
Plug 'junegunn/rainbow_parentheses.vim'

"Misc code editing
Plug 'scrooloose/syntastic'
Plug 'Raimondi/YAIFA'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

"Misc document editing
Plug 'tpope/vim-markdown', {'for' : 'markdown'}
Plug 'jtratner/vim-flavored-markdown', {'for' : 'markdown'}
Plug 'lervag/vimtex'
Plug 'junegunn/goyo.vim'

Plug 'goldfeld/vim-seek'
Plug 'haya14busa/incsearch.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'chrisbra/SudoEdit.vim'
Plug 'jiangmiao/auto-pairs'

call plug#end()



let mapleader=" "
let maplocalleader=" "

" cTags
set tags=./tags;$HOME
map <leader>ct :!ctags -R .


"Theme
syntax enable
filetype plugin indent on
set t_Co=256
colorscheme gotham
set bg=dark
set ff=unix


" Behaviour
set nobackup
set noswapfile	
set wrap
set linebreak
set nolist
set autoread
set backspace=indent,eol,start
set so=10
set lazyredraw
set ttyfast
set clipboard=unnamed
set hidden
set ttimeoutlen=50
set nocompatible
set mouse=a                     " No mouse
set shell=/bin/zsh              "Default shell
set nowb			            " Prevents automatic write backup before overwriting file
set diffopt+=vertical           " Always use vertical diffs

" Visual
set splitright
set completeopt=menu
set cursorline
set wildmenu
set laststatus=2
set noshowmode " We use airline!
set number


" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch


" Indendation
set smartindent "Clever indent
set autoindent " Indent automatically
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab




" Cursor
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"



" Leader mappings
" Remaps
" Plugins



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

"Annoying that star goes to the next match
nnoremap * *N



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

" Vimwiki
let g:vimwiki_list = [{'path':'~/Notes', 'path_html':'~/.cache/vimwiki/html'}]

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

" function! s:goyo_enter()
"     au!
"     autocmd InsertEnter * :set nonumber
"     autocmd InsertLeave * :set norelativenumber
"     au VimResized * exe "normal \<c-w>="
" endfunction
" autocmd! User GoyoEnter nested call <SID>goyo_enter()

" function! s:goyo_leave()
"     au!
"     au InsertEnter * set nornu
"     au InsertLeave * set rnu
" endfunction
" autocmd! User GoyoLeave nested call <SID>goyo_leave()

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
