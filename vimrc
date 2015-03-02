"" Plug

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'vim-scripts/a.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'gerw/vim-latex-suite'
Plug 'fatih/vim-go'
Plug 'tomasr/molokai'
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-sleuth'
Plug 'dag/vim-fish'
call plug#end()

"" VIM

" Looks
colorscheme molokai
set fillchars=vert:│,fold:─,diff:─
set t_Co=256

" Lines
set colorcolumn=80,81
set nojoinspaces
set wrap
set linebreak

" Tabs
set expandtab
set tabstop=8
set shiftwidth=4

" Paragraphs
set formatoptions+=2

" Numbers
set number
set relativenumber

" Search
set incsearch
set ignorecase
set smartcase

" Modeline
set modeline

" Context
set scrolloff=2

" Remember last lines
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif

" Persistent undo
if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo >/dev/null 2>&1
endif
set undodir=~/.vim/undo//
set undofile

"" Plugins

" A
let g:alternateExtensions_cc = "hh"
let g:alternateExtensions_hh = "cc"

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

" NERDTree
nmap <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1

"" Filetype

" Python
au FileType python setl nosmartindent

" Markdown
au BufRead,BufNewFile *.md setl filetype=markdown spell
au FileType markdown noremap <buffer> <Leader>r :!markdown "%" > "$(basename "%" .md).html"<cr><cr>

" R
au FileType r noremap <buffer> <leader>r :!clear && R --vanilla <% \| less<cr>
au FileType r noremap <buffer> <leader>p :!evince Rplots.pdf >/dev/null 2>&1 &<cr>

" Rust
au FileType rust setl keywordprg=uzbl-rust-std
au FileType rust noremap <buffer> <leader>r :!clear && cargo run<cr>
au FileType rust noremap <buffer> <leader>t :!clear && cargo test<cr>
au FileType rust noremap <buffer> <leader>b :!clear && cargo build<cr>
au FileType rust noremap <buffer> <leader>c :!clear && cargo clean<cr>
