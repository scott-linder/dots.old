" vimrc

" My TTY has a color ribbon.
syntax on

" No terminfo for termite; just assume 256 color term
set t_Co=256

" Gray on gray.
colorscheme molokai

" Vertical mark at column 80
set colorcolumn=80,81
hi ColorColumn ctermbg=234 guibg=#232526

" Window dividers
set fillchars=vert:│,fold:─,diff:─

" Don't use two spaces between sentences
set nojoinspaces

" Wrap lines and indicate when they are wrapped
set wrap
set showbreak=»

" Four spaces instead of tabs
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4

" Indent based upon file type
if has("autocmd")
    filetype plugin indent on
endif

" Indentation
set autoindent
set smartindent
if has("autocmd")
    " smartindent messes with commenting in python
    au FileType python setl nosmartindent
endif

" Markdown
if has("autocmd")
    au BufRead,BufNewFile *.md set filetype=md
endif
map <Leader>lm :w !markdown % > `basename % .md`.html<Enter><Enter>

" Allow first line of paragraph to have its own indentation
set fo+=2

" Line Numbers
set number

" Smart Search (case sensitive when upper-case letters are in search)
set ignorecase
set smartcase

" Incremental search
set incsearch

" auto-complete paths (C-N)
set path+=/usr/include/**

" Remember last lines
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
endif

" Remember undo history in one unified location
if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
endif
set undodir=./.vim-undo//
set undodir+=~/.vim/undo//
set undofile

" Treat broken-lines as separate lines while moving around
noremap j gj
noremap k gk

" Easy movement between tabs
noremap <A-h> gT
noremap <A-l> gt

" Always show status line
"set laststatus=2

" Don't preview one line of minimized windows
set wmh=0
set wmw=0

" Taglist Options
" Open on keybind
nmap <C-t> :TlistOpen<CR>
" Close the list when something is selected
let Tlist_Close_On_Select = 1
let Tlist_GainFocus_On_ToggleOpen = 1

" NERDTree
nmap <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1

" Latex-Suite
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
let g:tex_comment_nospell = 1
let g:Tex_Folding = 0
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
let g:Tex_FormatDependancy_pdf = 'pdf'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf'
let g:Tex_ViewRule_pdf = 'evince'

" Clang Autocompelte
" Function autocomplete argument placeholders
let g:clang_snippets = 1
let g:clang_snippets_engine = 'clang_complete'
" Placeholder at the end of a function
let g:clang_trailing_placeholder = 1
" Quickly move between placeholders with shift-tab
imap <S-Tab> <Esc><Tab>
" Tell vim not to show the 'markup' for placeholders
set concealcursor=""
set conceallevel=2
" Close annoying window after completion
let g:clang_close_preview = 1
" Use libclang, not clang binary
let g:clang_use_library = 1
" Complete preprocessor stuff
let g:clang_complete_macros = 1
" Complete code patters (if, loops, etc)
let g:clang_complete_patterns = 1

" A
let g:alternateExtensions_cc = "hh"
let g:alternateExtensions_hh = "cc"
