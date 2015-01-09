"================================================
"
"   .vimrc - collection of vim configurations
"
"   Daeyun Shin (daeyun@daeyunshin.com)
"   Created         Aug 01, 2011
"   Last modified   Dec 14, 2014
"
"================================================

" Plugin manager
"================================================================================
set nocompatible               " be iMproved
filetype off                   " required!

if has('nvim')
    runtime! plugin/python_setup.vim
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle
Plugin 'gmarik/Vundle.vim'

" Original repos on github
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'groenewege/vim-less'
Plugin 'ingydotnet/yaml-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'plasticboy/vim-markdown'
Plugin 'lazywei/vim-matlab'
Plugin 'reedes/vim-pencil'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'klen/python-mode'
Plugin 'reedes/vim-litecorrect'
Plugin 'danro/rename.vim'
Plugin 'rhysd/vim-clang-format'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tikhomirov/vim-glsl'
Plugin 'mkitt/tabline.vim'

" Plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Plugin 'mru.vim'
Plugin 'DoxygenToolkit.vim'
Plugin 'bufkill.vim'

" Forked repos
Plugin 'daeyun/vim-latex'

call vundle#end()            " required
filetype plugin indent on    " required

" This prevents having the autocommands defined twice (e.g., after sourcing the .vimrc file again).
autocmd!

" Plugin-dependent key bindings
"================================================================================
" CtrlP
"--------------------------------------------------------------------------------
nnoremap <silent> <Space> :CtrlPBuffer<CR>
" Specify an external tool for listing files
let g:ctrlp_user_command = 'find %s -type f'
" Windows
"let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
" Ignore those files
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll|swp|~|DS_Store)$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
    \ }

" Pressing <c-@> in Buffer mode will delete the selected buffer
let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }
func! MyCtrlPMappings()
    nnoremap <buffer> <silent> <c-@> :call <sid>DeleteBuffer()<cr>
endfunc
func! s:DeleteBuffer()
    let line = getline('.')
    let bufid = line =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(line, '\d\+'))
        \ : fnamemodify(line[2:], ':p')
    exec "bd" bufid
    exec "norm \<F5>"
endfunc

let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
" fzf fuzzy finder
"--------------------------------------------------------------------------------
set rtp+=~/.fzf
" YouCompleteMe
"--------------------------------------------------------------------------------
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>


" NERD Tree
"--------------------------------------------------------------------------------
map <leader>n :NERDTreeToggle<cr>


" MRU
"--------------------------------------------------------------------------------
map <leader>m :MRU<cr>


" clang-format
"--------------------------------------------------------------------------------
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
autocmd FileType c,cpp,objc nmap <Leader>C :ClangFormatAutoToggle<CR>


" Commands
"================================================================================
" Remap Caps Lock to ESC, Ctrl
command! Mapesc :!xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
command! Mapctrl :!xmodmap -e 'clear Lock' -e 'keycode 0x42 = Control_L' -e 'add Control = Control_L'

" Show invisible characters. e.g. tabs, end of line, trailing whitespaces
let g:is_invisible_visible = 0
function! ToggleShowInvisible()
    if g:is_invisible_visible
        set nolist listchars=eol:$
    else
        set list listchars=eol:$,tab:»·,trail:·,extends:>,precedes:<,nbsp:~
    endif
    let g:is_invisible_visible = !g:is_invisible_visible
endfunction
command! ToggleInvisible :call ToggleShowInvisible()


" Generic, non-interactive config without plugin dependency
"================================================================================
" Temp file paths
"--------------------------------------------------------------------------------
" Keep swap files in one location
if !isdirectory("~/.vim/tmp/")
    silent !mkdir ~/.vim/tmp/ > /dev/null 2>&1
endif
set directory=$HOME/.vim/tmp//,.  
" .viminfo file location
set viminfo='20,\"50
set viminfo+=n~/.vim/tmp/.viminfo

" Appearance
"--------------------------------------------------------------------------------
" Enable 256 colors
set t_Co=256
" OS, interface specific
if has("gui_running")
    if has("gui_gtk2")
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
        "set guifont=Andale\ Mono\ 9\.5
        "set guifont=Andale\ Mono\ 12
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    elseif system("uname") == "Darwin\n"
        set guifont=Inconsolata\ for\ Powerline:h15
    endif

    " Minimalistic gvim interface
    set guioptions+=TmlrLRb
    set guioptions-=TmlrLRb

    "let g:zenburn_high_Contrast=1
    "colorscheme zenburn

    "colorscheme Tomorrow-Night

    " Pencil Theme
    colo pencil
    let g:pencil_terminal_italics = 1
    set background=light
    let g:airline_theme = 'pencil'

else
    colo molokai
    let g:airline_theme = 'molokai'
endif
" Fill the statuslines
set fillchars+=stl:\ ,stlnc:\

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" File names, types
"--------------------------------------------------------------------------------
autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype ocaml setlocal ts=2 sts=2 sw=2 tw=200
autocmd Filetype tex setlocal ts=2 sts=2 sw=2 spell
autocmd Filetype cpp setlocal ts=2 sts=2 sw=2
" Default filetype is txt
autocmd BufEnter * if &filetype == "" | setlocal ft=txt | endif
" Reload .vimrc on save
autocmd BufWritePost .vimrc source %
" Encrypted file config
autocmd BufReadPre * if system("head -c 9 " . expand("<afile>")) == "VimCrypt~" | call SetupEncryption() | endif
function! SetupEncryption()
    " disable the swap file
    setlocal noswapfile
    " disable viminfo (global)
    set viminfo=
    " auto-close folds
    setlocal foldlevel=0
    setlocal foldclose=all
    " make it harder to open folds by accident
    setlocal foldopen=""
    " move cursor over word and press 'e' to obfuscate/unobfuscate it
    noremap <buffer> e g?iw

    setlocal foldexpr=getline(v\:lnum)=~'^\\s\\|^$'
    setlocal nobackup nonumber bufhidden=wipe
endfunction
" Create parent directries on save
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END


" Built-in, uncategorized
"--------------------------------------------------------------------------------
set wmh=0
set modeline
set encoding=utf-8
set termencoding=utf-8
set history=1000
let html_no_rendering=1
filetype plugin on
set foldlevel=99

" Encryption method
setlocal cm=blowfish

" Turn on syntax highlighting.
syntax on

set foldmethod=indent             " Lines with equal indent form a fold.
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
set scrolloff=2                   " Show 2 lines of context around the cursor.
set sidescrolloff=5               " Show 5 characters of horizontal context around the cursor.
set title                         " Set the terminal's title
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set laststatus=2                  " Show the status line all the time

" Disable flashing and beeping
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
" Indentation
set noautoindent smartindent
" Making sure hardtabs are never entered
set softtabstop=4
set expandtab
set shiftwidth=4
set shiftround
set nojoinspaces
" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
endif
" Turn off CTRL-A and CTRL-X commands using base 8 for numbers starting with a zero.
set nrformats-=octal
" Timeout when part of a mapped key sequence or keyboard code has been received.
set ttimeout timeoutlen=700 ttimeoutlen=100
" When a file has been detected to have been changed outside of Vim and it has
" not been changed inside of Vim, automatically read it again.
set autoread
set smarttab

" Non-interactive, plugin-specific
"================================================================================

" Gist
"--------------------------------------------------------------------------------
let g:gist_post_private = 1


" Vim Markdown
"--------------------------------------------------------------------------------
let g:vim_markdown_folding_disabled = 1


" Airline
"--------------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
"let g:airline_left_sep='>'
"let g:airline_right_sep='<'


" YouCompleteMe
"--------------------------------------------------------------------------------
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"Do not ask when starting vim
let g:ycm_confirm_extra_conf = 0
let g:syntastic_always_populate_loc_list = 1
let g:ycm_collect_identifiers_from_tags_files = 1
set tags+=./.tags


" SirVer/ultisnips
"--------------------------------------------------------------------------------
" Trigger configuration. Do not use <tab> if you use /Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" Vim-LaTeX
"--------------------------------------------------------------------------------
let Tex_FoldedSections=""
let Tex_FoldedEnvironments=""
let Tex_FoldedMisc=""
let g:Tex_GotoError=0

" Compiling and synctex support
let g:Tex_DefaultTargetFormat = 'pdf'

let g:Tex_CompileRule_dvi = 'latex --interaction=nonstopmode $*'
let g:Tex_CompileRule_ps = 'dvips -Pwww -o $*.ps $*.dvi'
let g:Tex_CompileRule_pspdf = 'ps2pdf $*.ps'
let g:Tex_CompileRule_dvipdf = 'dvipdfm $*.dvi'
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 --interaction=nonstopmode $*'

let g:Tex_ViewRule_dvi = 'texniscope'
let g:Tex_ViewRule_ps = 'Preview'
let g:Tex_ViewRule_pdf = 'Skim'

let g:Tex_FormatDependency_ps  = 'dvi,ps'
let g:Tex_FormatDependency_pspdf = 'dvi,ps,pspdf'
let g:Tex_FormatDependency_dvipdf = 'dvi,dvipdf'

" let g:Tex_IgnoredWarnings ='
"       \"Underfull\n".
"       \"Overfull\n".
"       \"specifier changed to\n".
"       \"You have requested\n".
"       \"Missing number, treated as zero.\n".
"       \"There were undefined references\n".
"       \"Citation %.%# undefined\n".
"       \"\oval, \circle, or \line size unavailable\n"'


" vim-pencil
"--------------------------------------------------------------------------------
let g:pencil#wrapModeDefault = 'soft'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init() |
                              \ call litecorrect#init() |
                              \ setl spell spl=en_us fdl=4 noru nonu nornu |
                              \ setl fdo+=search
  autocmd Filetype mail         call pencil#init({'wrap': 'hard', 'textwidth': 60}) |
                              \ call litecorrect#init() |
                              \ setl spell spl=en_us et sw=2 ts=2 noai nonu nornu
  autocmd Filetype html,xml     call pencil#init({'wrap': 'soft'}) |
                              \ call litecorrect#init() |
                              \ setl spell spl=en_us et sw=2 ts=2
augroup END


" easymotion
"--------------------------------------------------------------------------------
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


" clang-format
"--------------------------------------------------------------------------------
let g:clang_format#detect_style_file = 1


" Key bindings based on built-in features
"================================================================================
" Easier window navigation
nnoremap <m-j> <c-w>j
nnoremap <m-k> <c-w>k
nnoremap <m-l> <c-w>l
nnoremap <m-h> <c-w>h

" Window resizing
nnoremap <esc>m <C-w>3+
nnoremap <esc>n <C-w>3-
nnoremap <C-n> <C-W>3<
nnoremap <C-m> <C-W>3>

" Moving windows
nnoremap <esc>K <C-w>K
nnoremap <esc>J <C-w>J
nnoremap <esc>H <C-w>H
nnoremap <esc>L <C-w>L
nnoremap <esc>R <C-w>R
nnoremap <esc>r <C-w>r

" Press left and right arrow keys to switch buffers
nnoremap <silent> <right> :bn<CR>
nnoremap <silent> <left> :bp<CR>

" Toggle paste mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Tab mappings
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

map <esc>1 1gt
map <esc>2 2gt
map <esc>3 3gt
map <esc>4 4gt
map <esc>5 5gt
map <esc>6 6gt
map <esc>7 7gt

nnoremap <leader>bd :BD
nnoremap <leader>bq :BD!


" Save as root
cmap w!! %!sudo tee > /dev/null %

" Scroll 3 lines with arrow keys
noremap <down> 3<C-e>
noremap <up> 3<C-y>

" Press <C-v> to paste with pastemode, <C-f> for old <C-v> functionality.
inoremap <C-f> <C-v>
inoremap <C-v> <ESC>"+p`]a

" Allow deleting selection without updating the yank buffer
vnoremap x "_x
vnoremap X "_X

" Press <ESC> twice to unhilight
map <ESC><ESC> :noh<CR>

" Mapping to quickly change curly braces to K&R style
map <leader>[] :%s/n[ \t\n]*{/ {/g<CR>

" Save using :ww in addition to :w<cr>
cmap ww w<cr>

" Enter command-line mode without having to press the shift key
nnoremap ; :
vnoremap ; :

" Swap lines
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==

" Run Flake8
autocmd FileType python map <buffer> <leader>8 :call Flake8()<CR>

" Toggle comments
vmap <Space> <leader>ci
nmap <S-Space> <leader>ci

" press <F9> to execute the current buffer with python
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

" Press F3 to output a timestamp
nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

" Ctrl-C will unhighlight
map <C-c> :noh<CR>

" Emacs-like
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0

" Move between long lines
map j gj
map k gk

nnoremap <C-@> `

if has("gui_running")
    inoremap <c-h> <c-g>u<Esc>[s1z=`]A<c-g>u
    nnoremap <c-h> [s1z=<c-o>
else
    " C-Y in visual mode will copy to clipboard
    vnoremap <C-y> my"*y
endif

" Be able to undo Ctrl-U in insert mode
inoremap <c-u> <c-g>u<c-u>

nnoremap <c-d> <c-f>
nnoremap <c-u> <c-b>

