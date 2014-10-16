set nocompatible               " be iMproved
filetype off                   " required!

if has('nvim')
    runtime! plugin/python_setup.vim
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/Vundle.vim'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
Bundle 'mattn/zencoding-vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'nvie/vim-flake8'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-notes'
Bundle 'groenewege/vim-less'
Bundle 'ingydotnet/yaml-vim'
Bundle 'derekwyatt/vim-scala'
Bundle 'Valloric/YouCompleteMe'
Bundle 'kien/ctrlp.vim'
" vim-scripts repos
Bundle 'L9'
Bundle 'mru.vim'
Bundle 'flazz/vim-colorschemes'
Bundle 'bling/vim-airline'
Bundle 'airblade/vim-gitgutter'
Bundle 'godlygeek/tabular'
Bundle 'plasticboy/vim-markdown'
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
" ...

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

set foldmethod=indent
set foldlevel=99

" Easier window navigation
map <m-j> <c-w>j
map <m-k> <c-w>k
map <m-l> <c-w>l
map <m-h> <c-w>h

" Window resizing
map <m-m> <C-w>3+
map <m-n> <C-w>3-
map <C-n> <C-W>3<
map <C-m> <C-W>3>

" Moving windows
map <m-K> <C-w>K
map <m-J> <C-w>J
map <m-H> <C-w>H
map <m-L> <C-w>L
map <m-R> <C-w>R
map <m-r> <C-w>r

set wmh=0
set modeline

map <S-F11> :!xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
map <C-F11> :!xmodmap -e 'clear Lock' -e 'keycode 0x42 = Control_L' -e 'add Control = Control_L'

set encoding=utf-8

let html_no_rendering=1

"let g:ycm_global_ycm_extra_conf = '/home/daeyun/.vim/extra/'

" Minimalistic gvim interface
:set guioptions+=TmlrLRb
:set guioptions-=TmlrLRb

filetype plugin on

autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype ocaml setlocal ts=2 sts=2 sw=2 tw=200
set t_Co=256

nnoremap <silent> <right> :bn<CR>
nnoremap <silent> <left> :bp<CR>

syntax on                     " Turn on syntax highlighting.

if has("gui_running")
    if has("gui_gtk2")
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
        "set guifont=Andale\ Mono\ 9\.5
        "set guifont=Andale\ Mono\ 12
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif

    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        set guifont=Inconsolata\ for\ Powerline:h15
    endif

    "let g:zenburn_high_Contrast=1
    "colorscheme zenburn
    colorscheme Tomorrow-Night
else
    colorscheme Tomorrow-Night
endif

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set laststatus=2                  " Show the status line all the time

"set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
"set statusline=%F%m%r%h%w\ [FF=%{&ff}]\ [T=%Y]\ [A=\%03.3b]\ [H=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline=%{GitBranch()}

" toggle paste mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

map <leader>n :NERDTreeToggle<cr>
map <leader>m :MRU<cr>

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

cmap w!! %!sudo tee > /dev/null %

" disable flashing and beeping
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set history=50
set viminfo='20,\"50

" scroll 3 lines with arrow keys
noremap <down> 3<C-e>
noremap <up> 3<C-y>

set noautoindent smartindent
"The rest deal with whitespace handling and
"mainly make sure hardtabs are never entered
set softtabstop=4
set expandtab
set shiftwidth=4
set shiftround
set nojoinspaces

"allow deleting selection without updating the clipboard (yank buffer)
vnoremap x "_x
vnoremap X "_X

map <ESC><ESC> :noh<CR>

"nnoremap <Space> 10<C-d>
"nnoremap <S-Space> 10<C-u>

map <leader>[] :%s/\n[ \t\n]*{/{/g<CR>

cmap ww w<cr>

" swap colon and semicolon
nnoremap ; :
" nnoremap : ;
"
vnoremap ; :
" vnoremap : ;

nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
nnoremap <C-h> <<
nnoremap <C-l> >>
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
inoremap <C-h> <Esc><<`]a
inoremap <C-l> <Esc>>>`]a
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

" Run Flake8
autocmd FileType python map <buffer> <leader>8 :call Flake8()<CR>

" Toggle comments
vmap <Space> <leader>ci
nmap <S-Space> <leader>ci

" press <F9> to execute the current buffer with python
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

autocmd BufWritePost *.coffee compiler cake
autocmd BufWritePost *.coffee silent make! build-dev

autocmd BufWritePost *.less compiler cake
autocmd BufWritePost *.less silent make! build-css

map j gj
map k gk

nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows

" CtrlP
nnoremap <silent> <Space> :CtrlPBuffer<CR>

" Powerline
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8

let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"let g:airline_left_sep='>'
let g:airline_left_sep = ''
"let g:airline_right_sep='<'
let g:airline_right_sep = ''

map <C-c> :noh<CR>

inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0
autocmd! BufWritePost .vimrc source %

let g:vim_markdown_folding_disabled=1
