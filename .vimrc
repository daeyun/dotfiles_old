set nocompatible

"pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
"end of pathogen

filetype plugin on

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

vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

set wmh=0

" Execute file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!python % <CR>

set modeline

map <S-F11> :!xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
map <S-C-F11> :!xmodmap -e 'clear Lock' -e 'keycode 0x42 = Control_L' -e 'add Control = Control_L'

set encoding=utf-8

let html_no_rendering=1
imap ,/ </<C-X><C-O>
inoremap jj <ESC>
inoremap ii <ESC>

" Minimalistic gvim interface
:set guioptions+=TmlrLRb
:set guioptions-=TmlrLRb

let python_highlight_all = 1
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
" map <leader>c :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <leader>c :!ctags -R ./*<CR>

set t_Co=256

" Buffers - explore/next/previous
nnoremap <silent> <C-b> :BufExplorer<CR>
"nnoremap <silent> <F12> :bn<CR>
"nnoremap <silent> <S-F12> :bp<CR>

nnoremap <silent> <right> :bn<CR>
nnoremap <silent> <left> :bp<CR>

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

syntax on                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.
set nocp  "for omnicppcomplete

if has("gui_running")
    if has("gui_gtk2")
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 9\.5
        "set guifont=Andale\ Mono\ 9\.5
        "set guifont=Andale\ Mono\ 12
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif

    let g:zenburn_high_Contrast=1
    colorscheme zenburn
else
    " colorscheme zenburn
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

set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{GitBranch()}\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
"set statusline=%F%m%r%h%w\ [FF=%{&ff}]\ [T=%Y]\ [A=\%03.3b]\ [H=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline=%{GitBranch()}


" Highlight end of line whitespace.
" highlight WhitespaceEOL ctermbg=red guibg=red
" match WhitespaceEOL /\s\+$/

" Execute a selection of code
" Use VISUAL to select a range and then hit ctrl-h to execute it.
" python << EOL
" import vim
" def EvaluateCurrentRange():
"     eval(compile('\n'.join(vim.current.range),'','exec'),globals())
" EOL
" map <leader>h :py EvaluateCurrentRange()<cr>

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

"undo & redo
noremap <F9> g-
noremap <F10> g+

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

map <C-t> :TaskList<CR>
map T :TlistToggle<CR>

map <F2> :NERDTreeToggle<CR>

map <ESC><ESC> :noh<CR>

imap <m-BS> <C-W>

"nnoremap <Space> 10<C-d>
"nnoremap <S-Space> 10<C-u>

map <leader>[] :%s/\n[ \t\n]*{/{/g<CR>

" swap colon and semicolon
nnoremap ; :
" nnoremap : ;
"
vnoremap ; :
" vnoremap : ;

" Automatic fold settings for specific files. Uncomment to use.
" autocmd FileType ruby setlocal foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

autocmd BufWritePost,FileWritePost *.coffee silent !coffee -c <afile>
autocmd BufWritePost,FileWritePost *.less silent !lessc <afile> <afile>:r.css
